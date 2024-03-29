<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<link rel="stylesheet" href="${cssUrl}/link.css">

<jsp:include page="../component/subBanner.jsp"></jsp:include>
<section class="contents">
    <jsp:include page="../component/subTitle.jsp"></jsp:include>
    <div class="mainContent">
        <form>
            <div class="link-table-wrapper">
                <div class="link-table-box-top">
                    <div class="link-table-box-top-left">
                        <div class="link-inputs-row">
                            <div class="common-input-box">
                                <div class="header6 label-title">테이블명</div>
                                <input class="common-input subtitle1 gray400" type="text" name="tbl_nm" placeholder="PUB_TEST_TABLE" readonly>
                            </div>
                            <div class="common-input-box">
                                <div class="header6 label-title">인터페이스 제목</div>
                                <input class="common-input subtitle1 gray400" type="text" name="if_nm" placeholder="인터페이스">
                            </div>
                        </div>
                        <div>
                            <div class="common-input-box">
                                <div class="header6 label-title">스케줄<span id="infoIcon">ℹ️</span></div>
                                <input class="common-input subtitle1 gray400" type="text" name="lnk_time" placeholder="스케줄">
                            </div>
                            <div class="common-input-box" id="flagTypeInput">
                                <div class="header6 label-title">WHERE</div>
                                <input class="common-input subtitle1 gray400" type="text" name="" placeholder="조건문을 입력하세요">
                            </div>
                        </div>
                    </div>
                    <div class="link-table-box-top-right">
                        <div class="flag-box">
                            <div class="flag-title body1 gray500 bg-gray200 border-gray300">연계플래그 타입</div>
                            <div class="flag-radio-box subtitle1 gray400">
                                <div>
                                    <label><input type="radio" name="flag_type" value="1" checked="checked">STATUS</label>
                                </div>
                                <div>
                                    <label><input type="radio" name="flag_type" value="2">QUERY</label>
                                </div>
                                <div>
                                    <label><input type="radio" name="flag_type" value="3">WHERE</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="link-table-box-bottom">
                    <table class="data-list">
                        <colgroup>
                            <col width="45%">
                            <col width="15%">
                            <col width="10%">
                            <col width="10%">
                            <col width="20%">
                        </colgroup>
                        <thead class="list-head">
                            <tr class="subtitle1 gray500">
                                <th>컬럼명</th>
                                <th>컬럼타입</th>
                                <th>DEFUALT</th>
                                <th>연계여부</th>
                                <th>연계 플래그 매핑</th>
                            </tr>
                            <tr class="table-spacing"></tr>
                        </thead>
                        <tbody class="list-body">
                            <tr class="subtitle1 gray500">
                                <td>COLUMN1</td>
                                <td>VARCHAR2(100)</td>
                                <td>timestamp();</td>
                                <td>
                                    <input type="checkbox" name="use_yn" id="use_yn" onclick="colUseCheck()">
                                </td>
                                <td>
                                    <select>
                                        <option value="1">STATUS</option>
                                        <option value="2">QUERY</option>
                                        <option value="3">WHERE</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="table-spacing"></tr>
                            <tr class="subtitle1 gray500">
                                <td>COLUMN2</td>
                                <td>VARCHAR2(100)</td>
                                <td>timestamp();</td>
                                <td>
                                    <input type="checkbox" name="use_yn" id="use_yn" onclick="colUseCheck()">
                                </td>
                                <td>
                                    <select>
                                        <option value="1">STATUS</option>
                                        <option value="2">QUERY</option>
                                        <option value="3">WHERE</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="table-spacing"></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="query-box">
                <h4 class="query-title body1 gray500">조회쿼리</h4>
                <div class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
            </div>
            <div class="link-button-box">
                <input class="button-second" type="button" value="이전" onclick="history.back()">
                <input class="button-primary" type="button" value="저장" id="regbtn" onclick="location.href='${homeUrl}linkList'">
            </div>
        </form>
    </div>

    <script>
        $(document).ready(function () {
            //배너 타이틀 세팅
            $('.banner-title').text('연계서비스')
            $('.banner-sub-title').text('연계서비스를 제공합니다')
            //페이지 타이틀 세팅
            $('.main-title-text').text('연계서비스 테이블 상세');
            $('.navi-arrow').text(' > 연계서비스 > 연계서비스 등록 > 연계서비스 항목 설정 > 연계 테이블 상세');

            $('#flagTypeInput').css('display', 'none');
        });

        function colUseCheck() {
            const use_yn = $("#use_yn").val;
            console.log("@@@@@@@@@@@@" + use_yn);
        }
    </script>

</section>