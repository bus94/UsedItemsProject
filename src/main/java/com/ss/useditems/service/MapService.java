package com.ss.useditems.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.useditems.dto.LocationDTO;
import com.ss.useditems.mapper.MapMapper;

@Service
public class MapService {
	@Autowired
	private MapMapper mapper;
	

    public List<LocationDTO> getMarkers(String add) {
        return mapper.getMarkers(add);
    }
}
