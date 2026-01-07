package com.geekive.geekiveMydic.geekiveCustom;

import java.util.ArrayList;
import java.util.List;

import com.geekive.geekiveMydic.common.Constants;

public class GeekivePaginator {

	private int currentPageNumber;
	private int dataTotalCount;
	private int dataCountPerPage					= Constants.dataCountPerPage;
	private int pageButtonCountPerPage 				= Constants.pageButtonCountPerPage;
	private int pageButtonTotalCount				= 0;
	private int currentPageButtonGroupIndex 		= 0;
	private int lastPageButtonGroupIndex			= 0;
	private int pageNumberToPreviousPageButtonGroup	= 0;
	private int pageNumberToNextPageButtonGroup		= 0;
	
    private GeekivePaginator(Builder builder) {
    	this.currentPageNumber 						= builder.currentPageNumber;
    	this.dataTotalCount 						= builder.dataTotalCount;
    	this.dataCountPerPage						= builder.dataCountPerPage != 0 ? builder.dataCountPerPage : this.dataCountPerPage;

    	this.currentPageButtonGroupIndex 			= this.currentPageNumber % this.pageButtonCountPerPage > 0 ? this.currentPageNumber / this.pageButtonCountPerPage : (this.currentPageNumber / this.pageButtonCountPerPage) - 1;
		
    	this.pageNumberToPreviousPageButtonGroup 	= currentPageButtonGroupIndex * pageButtonCountPerPage;
		this.pageNumberToNextPageButtonGroup		= pageNumberToPreviousPageButtonGroup + pageButtonCountPerPage + 1;

		if(this.dataTotalCount > this.dataCountPerPage) {
			this.pageButtonTotalCount = (this.dataTotalCount / dataCountPerPage) + (this.dataTotalCount % dataCountPerPage > 0 ? 1 : 0);
		}else {
			this.pageButtonTotalCount = 1;
		}
		
		this.lastPageButtonGroupIndex = this.pageButtonTotalCount % this.pageButtonCountPerPage > 0 ? this.pageButtonTotalCount / this.pageButtonCountPerPage : (this.pageButtonTotalCount / this.pageButtonCountPerPage) - 1;
    }
	
	public GeekiveMap getPaginationMap() {
		GeekiveMap paginationMap = new GeekiveMap();
		paginationMap.put("flagPreviousPageButtonGroup"			, currentPageButtonGroupIndex == 0 ? false : true);
		paginationMap.put("flagNextPageButtonGroup"				, currentPageButtonGroupIndex == lastPageButtonGroupIndex ? false : true);
		paginationMap.put("pageNumberToPreviousPageButtonGroup"	, pageNumberToPreviousPageButtonGroup);
		paginationMap.put("pageNumberToNextPageButtonGroup"		, pageNumberToNextPageButtonGroup);
		paginationMap.put("currentPageNumber"					, currentPageNumber);
		paginationMap.put("pageNumberList"						, getPageNumberList());
		return paginationMap;
	}
	
	private List<Integer> getPageNumberList() {
		List<Integer> pageNumberList = new ArrayList<Integer>();
		int pageStartNumber = pageNumberToPreviousPageButtonGroup + 1;
		int pageEndNumber	= pageNumberToNextPageButtonGroup <= pageButtonTotalCount ? pageNumberToNextPageButtonGroup - 1 : pageButtonTotalCount;		
		for(int i = pageStartNumber; i <= pageEndNumber; i++) {
			pageNumberList.add(i);
		}
		return pageNumberList;
	}
	
    public static class Builder {
    	private int currentPageNumber;
    	private int dataTotalCount;
    	private int dataCountPerPage;

        public Builder currentPageNumber(int currentPageNumber) throws Exception {
            this.currentPageNumber = currentPageNumber;
            return this;
        }
        
        public Builder dataTotalCount(int dataTotalCount) throws Exception {
            this.dataTotalCount = dataTotalCount;
            return this;
        }
        
        public Builder dataCountPerPage(int dataCountPerPage) throws Exception {
            this.dataCountPerPage = dataCountPerPage;
            return this;
        }

        public GeekivePaginator build() {
            return new GeekivePaginator(this);
        }
    }
    
    public static int parseCurrentPageNumber(Object currentPageNum) {
        if(currentPageNum == null) {
        	return 1;
        }
        
        if(currentPageNum instanceof Integer) {
        	return (int) currentPageNum;
        }else if(currentPageNum instanceof String) {
        	try {
                int parsedValue = Integer.parseInt((String) currentPageNum);
                return Math.max(parsedValue, 1);
			} catch (NumberFormatException e) {
                return 1;
			}
        }
        return 1;
    }
}
