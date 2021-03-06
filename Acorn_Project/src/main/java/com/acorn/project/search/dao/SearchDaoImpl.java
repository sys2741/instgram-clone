package com.acorn.project.search.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.acorn.project.search.dto.SearchDto;

@Repository
public class SearchDaoImpl implements SearchDao{
	@Autowired
	private SqlSession session;
	
	

	@Override
	public List<SearchDto> getList(String value) {
		//System.out.print(value);
		return session.selectList("search.getList", value);
	}

	@Override
	public List<SearchDto> getListTag(String value) {
		return session.selectList("search.getListTag", value);
	}

	@Override
	public List<SearchDto> getListHuman(String value) {
		return session.selectList("search.getListHuman", value);
	}

	@Override
	public List<SearchDto> getListDefault() {

		return session.selectList("search.getListDefault");
	}

	@Override
	public SearchDto getUserOwnList(String value) {
		return session.selectOne("search.getUserOwnList" , value);
		
	}

	@Override
	public List<SearchDto> getBoardPicture(String value) {
		System.out.println(value);
		return session.selectList("search.getBoardList", value);
	}

	@Override
	public int isFollowed(SearchDto dto) {
		return session.selectOne("search.isFollowed", dto);
	}

	@Override
	public void isFollow(SearchDto dto) {
		session.update("search.doFollow", dto);
		
	}

	@Override
	public void isNotFollow(SearchDto dto) {
		session.delete("search.removeFollow", dto);
		
	}

	

}
