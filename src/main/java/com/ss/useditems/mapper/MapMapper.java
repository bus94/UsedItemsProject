package com.ss.useditems.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ss.useditems.dto.LocationDTO;

@Mapper
public interface MapMapper {

	List<LocationDTO> getMarkers(String add);
   
}
