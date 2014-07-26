#include <stdio.h>
#include <string.h>
#include <curl/curl.h>
#include <file.h>
#include <android/log.h>

#define READ_SIZE_PER_TIME (4 * 1024)
#define MAX_READ_SIZE  (READ_SIZE_PER_TIME * 2)

#define CURL_TRUE 1
#define CURL_FALSE 0

#define LOG_TAG "libmupdf"
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR,LOG_TAG,__VA_ARGS__)

char wr_buf[MAX_READ_SIZE + 2];
int  wr_index;
char tempBuffer[1024];
int contentLen = -1;


int curl_read(void *ptr, size_t size, int offset, char *url);
size_t write_data( void *buffer, size_t size, size_t nmemb, void *userp );
int curl_fopen(char *url);
int curl_seek(int curpos, int offset, int whence);
int curl_close();

/*
 * Write data callback function (called within the context of 
 * curl_easy_perform.
 */
size_t write_data( void *buffer, size_t size, size_t nmemb, void *userp )
{
  int segsize = size * nmemb;

  //LOGE("write_data  %d %d", size, nmemb);

  if (wr_index + segsize >= MAX_READ_SIZE ) 
  {
    *(int *)userp = 1;
    return 0;
  }

  /* Copy the data from the curl buffer into our buffer */
  memcpy( (void *)&wr_buf[wr_index], buffer, (size_t)segsize);

  wr_index += segsize;

  /* Null terminate the buffer */
  wr_buf[wr_index] = 0;

  /* Return the number of bytes received, indicating to curl that all is okay */
  return (segsize);   //Tell all data consumed even in case buffer is full. We always read 32KB chunks using byte range
}

size_t header_callback(char *buffer,   size_t size,   size_t nitems,   void *userdata)
{
  int hdrSize = size * nitems;
  char *ptr;

  if (hdrSize >= 1024)
  {
    LOGE("Header size is more %d", hdrSize);
    return 0;
  }

  /*Only content rabge is useful for us 
  Content-Range: bytes 1468195-1500963/3351392*/
  if (contentLen >= 0)
  {
    /*Already length known*/
    return hdrSize;
  }

  memcpy(tempBuffer, buffer, hdrSize);
  tempBuffer[hdrSize] = 0;

  //LOGE("Header %s", tempBuffer);
  if (NULL == strstr(tempBuffer, "Content-Range"))
  {
    //LOGE("Content-Range not found");
    return hdrSize;
  }

  if (NULL == strstr(tempBuffer, "bytes"))
  {
    /*Content range other then bytes..cannot use*/
    //LOGE("bytes not found");
    return hdrSize;
  }

  ptr = strrchr( tempBuffer, '/' );
  if (NULL == ptr)
  {
    /*COntent length not present*/
    //LOGE("/ not found");
    return hdrSize;
  }


  ptr++;
  //LOGE("len in str is %s" , ptr);
  contentLen = atoi(ptr);

  //LOGE("Content length %d", contentLen);

  return hdrSize;
}
  
int curl_fopen(char *url)
{
  int ret = 0;
  
  contentLen = -1;
  LOGE("OPENING CURL URL %s", url);
  ret = curl_read(tempBuffer, 100, 0, url);

  if (ret != 0)
    return 0;
  else
    return -1;
}

int curl_read(void *ptr, size_t size, int offset, char *url)
{
  char str[80];
  CURL *curl;
  CURLcode ret;
  int  wr_error;
  int hdr_error;
  int startPos;
  int endPos;
  int readBufferSize = size;
  int bytesToCopy;
  long failOnError = 1;

  //LOGE("curlread %d %d %s\n", size, offset, url);
  wr_error = 0;
  
  if ((readBufferSize <= 0) || (url == NULL) || (ptr == NULL))
  {
    return 0;
  }

  /* First step, init curl */
  curl = curl_easy_init();
  if (!curl) 
  {
    LOGE("couldn't init curl\n");
    return 0;
  }

  /* Tell curl the URL of the file we're going to retrieve */
  curl_easy_setopt( curl, CURLOPT_URL, url);

  /* Tell curl that we'll receive data to the function write_data, and
   * also provide it with a context pointer for our error return.
   */
  curl_easy_setopt( curl, CURLOPT_WRITEDATA, (void *)&wr_error );
  curl_easy_setopt( curl, CURLOPT_WRITEFUNCTION, write_data );
  curl_easy_setopt( curl,  CURLOPT_FAILONERROR, failOnError );
  curl_easy_setopt( curl, CURLOPT_HEADERDATA, (void *)&hdr_error );
  curl_easy_setopt( curl, CURLOPT_HEADERFUNCTION, header_callback); 

  startPos = offset;
  endPos = startPos + READ_SIZE_PER_TIME;

  sprintf(str, "%d-%d", startPos, endPos);

  curl_easy_setopt( curl, CURLOPT_RANGE, str);

  wr_index = 0;
  //LOGE("Setting wr_index to 0\n");

  /* Allow curl to perform the action */
  ret = curl_easy_perform( curl );


  /*if (0 == curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD, &contentLength))
  {
    LOGE("content length is %d", contentLength);
  }
  else
  {
    LOGE("content length failed is %d", contentLength);
  }*/

  //printf( "ret = %d (write_error = %d)\n", ret, wr_error );

  curl_easy_cleanup( curl );

  if ((ret == 0) && (wr_index != 0))
  {
    bytesToCopy = wr_index;
    if (readBufferSize < wr_index)
      bytesToCopy = readBufferSize;

    memcpy(ptr, wr_buf, bytesToCopy);
   
    wr_index = 0;

    //LOGE("curl_read ret success %d %d", bytesToCopy, wr_error);
    return bytesToCopy;
  }
  else
  {
    wr_index = 0;
    //LOGE("curl_read ret 0, failcode %d %d %d", ret, wr_index, wr_error);
    return 0;
  }
}

int curl_seek(int curPos, int offset, int whence)
{
  int pos;

  //LOGE("curl_seek %d %d %d", curPos, offset, whence);

  if (whence == SEEK_SET)
    pos = offset;
  else if (whence == SEEK_CUR)
    pos = curPos + offset;
  else if ((whence == SEEK_END) && (contentLen > 0))
    pos = contentLen + offset;
  else
    return -1;

  //LOGE("curl_seek ret %d", pos);
  if (pos < 0)
    pos = 0;

  if (contentLen > 0)
  {
    if (pos > contentLen)
      pos = contentLen;
  }
  
  return pos;
}

int curl_close()
{
  contentLen = -1;
  LOGE("curl_close");
  return 0;
}
