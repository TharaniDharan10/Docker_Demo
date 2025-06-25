package com.example.docker_demo.model;

import lombok.Data;


public class DataRequest {
    private String data;

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
