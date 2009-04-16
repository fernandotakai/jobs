package org.undone.utils

import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest
import org.springframework.web.multipart.MaxUploadSizeExceededException
import org.springframework.web.multipart.MultipartHttpServletRequest
import javax.servlet.http.HttpServletRequest

public class CustomMultipartResolver extends org.springframework.web.multipart.commons.CommonsMultipartResolver {

    static final String FILE_SIZE_EXCEEDED_ERROR = "fileSizeExceeded"

    public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) {

        try {
            return super.resolveMultipart(request)
        } catch (MaxUploadSizeExceededException e) {
            request.setAttribute(FILE_SIZE_EXCEEDED_ERROR, true);
            return new DefaultMultipartHttpServletRequest(request, [:], [:])
        }
    }
}
