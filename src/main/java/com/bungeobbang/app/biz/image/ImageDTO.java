package com.bungeobbang.app.biz.image;

public class ImageDTO {
	private int imageNum;	//이미지 번호
	private String imageWay;//이미지 경로
	private int boardNum;	//게시물 번호 fk
	private int memberNum; // 프로필 사진을 등록한 회원 번호
	
	//getter setter
	public int getImageNum() {
		return imageNum;
	}
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public void setImageNum(int imageNum) {
		this.imageNum = imageNum;
	}
	public String getImageWay() {
		return imageWay;
	}
	public void setImageWay(String imageWay) {
		this.imageWay = imageWay;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	@Override
	public String toString() {
		return "ImageDTO [imageNum=" + imageNum + ", imageWay=" + imageWay + ", boardNum=" + boardNum + "]";
	}
}
