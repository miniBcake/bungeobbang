package com.bungeobbang.app.biz.common;

import com.bungeobbang.app.biz.member.MemberDTO;

public enum SampleDataEnum {
    MEMBER_SAMPLE_DATA(
            new MemberDTO[] {
                    memberSetting("admin", "1234", "관리자", "관리자", "010-0000-0000", "default_profile.png", "ADMIN", "2024-02-01"),
                    memberSetting("bungeobbang@example.com", "password1", "김붕어빵", "붕어빵원정대", "010-1234-5678", "default_profile.png", "USER", "2024-01-01"),
                    memberSetting("email3@example.com", "password3", "Jim Doe", "jimdoe", "010-3456-7890", "default_profile.png", "USER", "2024-03-01"),
                    memberSetting("email4@example.com", "password4", "Jake Doe", "jaked", "010-4567-8901", "default_profile.png", "USER", "2024-04-01")
            }
    );

    private final Object[] dataList;

    SampleDataEnum(Object[] dataList) {
        this.dataList = dataList;
    }

    public Object[] getDataList() {
        return dataList;
    }

    //객체를 생성하고 setter로 값을 설정하는 메서드들 (기본 생성자로 사용하기 위함)
    //멤버
    private static MemberDTO memberSetting(String Email, String password, String name, String Nickname, String phone, String profileWay, String role, String hireDay) {
        MemberDTO dto = new MemberDTO();
        dto.setMemberEmail(Email);
        dto.setMemberPassword(password);
        dto.setMemberName(name);
        dto.setMemberNickname(Nickname);
        dto.setMemberPhone(phone);
        dto.setMemberProfileWay(profileWay);
        dto.setMemberRole(role);
        dto.setMemberHireDay(hireDay);
        return dto;
    }
}