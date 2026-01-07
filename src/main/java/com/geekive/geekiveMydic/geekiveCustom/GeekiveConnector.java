package com.geekive.geekiveMydic.geekiveCustom;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GeekiveConnector {

    private final URL url;
    private final HttpURLConnection httpUrlConnection;
    private final String jsonData;
    private final MultipartFile multipartFile;
    private String responseData;

    private GeekiveConnector(Builder builder) {
        this.url = builder.url;
        this.httpUrlConnection = builder.httpUrlConnection;
        this.jsonData = builder.jsonData;
        this.multipartFile = builder.multipartFile;
    }

    public GeekiveMap sendMultiPartFile(String partName) throws Exception {
        ByteArrayResource byteArrayResource = new ByteArrayResource(multipartFile.getBytes()) {
            @Override
            public String getFilename() {
                return multipartFile.getOriginalFilename();
            }
        };

        // set parameter in Multipart/form-data format
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
        MultiValueMap<String, Object> mvMap = new LinkedMultiValueMap<>();
        mvMap.add(partName, byteArrayResource);
        mvMap.add("name", multipartFile.getName());
        
        GeekiveMap gMap = (GeekiveMap) session.getAttribute("userMap");
        mvMap.add("registrationUser", gMap.getString("userUid"));

        // set http header
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.MULTIPART_FORM_DATA);

        // set http request body
        HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(mvMap, httpHeaders);

        // send file
        ResponseEntity<String> responseEntity = new RestTemplate().exchange(url.toString(), HttpMethod.POST, httpEntity, String.class);
        return new ObjectMapper().readValue(responseEntity.getBody(), GeekiveMap.class); // json into map
    }

    public void sendPost() throws Exception {
        send(HttpMethod.POST);
    }

    public void sendGet() throws Exception {
        send(HttpMethod.GET);
    }

    private void send(HttpMethod method) throws Exception {
        httpUrlConnection.setRequestMethod(method.name());
        httpUrlConnection.setRequestProperty("Content-Type", "application/json");
        httpUrlConnection.setDoOutput(true);

        try (OutputStream outputStream = httpUrlConnection.getOutputStream()) {
            outputStream.write(jsonData.getBytes());
            outputStream.flush();
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(httpUrlConnection.getInputStream()))) {
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                response.append(line);
            }
        }

        this.responseData = response.toString();
    }

    public String getResponseData() {
        return this.responseData;
    }

    public static class Builder {

        private final URL url;
        private final HttpURLConnection httpUrlConnection;
        private String jsonData = "";
        private MultipartFile multipartFile;

        public Builder(String url) throws Exception {
            this.url = new URL(url);
            this.httpUrlConnection = (HttpURLConnection) this.url.openConnection();
        }

        public Builder data(Map<?, ?> map) throws Exception {
            this.jsonData = new ObjectMapper().writeValueAsString(map);
            return this;
        }

        public Builder data(MultipartFile multipartFile) throws Exception {
            this.multipartFile = multipartFile;
            return this;
        }

        public GeekiveConnector build() {
            return new GeekiveConnector(this);
        }
    }
}

