package com.server.inventory.service.interfaces;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;


public interface ImageServices {
    Map<String, Object> UploadImage(MultipartFile file) throws IOException;
    Boolean DestroyImage(String public_id) throws IOException;
}
