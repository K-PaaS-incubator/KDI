<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url var="cssUrl" value="/css"/>
<c:url var="homeUrl" value="/" />
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
                            <!-- 크론탭 문법을 input에 직접 입력하는 UI, UI 확정 후 제거 필요 -->
                            <%--                            <div class="common-input-box">--%>
                            <%--                                <div class="header6 label-title">스케줄 1안--%>
                            <%--                                    <span class="guide-icon">--%>
                            <%--                                        <img src="/img/icon-guide-mark.png" alt="">--%>
                            <%--                                        ️<span id="guideText" class="guide-box bg-gray400 subtitle2 white100"></span>--%>
                            <%--                                    </span>--%>
                            <%--                                </div>--%>
                            <%--                                <input class="common-input subtitle1 gray400" type="text" name="lnk_time" placeholder="스케줄">--%>
                            <%--                            </div>--%>
                            <div class="schedule-input-box">
                                <div class="header6 label-title">스케줄
                                    <span class="guide-icon">
                                        <img src="/img/icon-guide-mark.png" alt="">
                                        ️<span id="guideText" class="guide-box bg-gray400 subtitle2 white100"></span>
                                    </span>
                                </div>
                                <div class="schedule-inputs">
                                    <input class="schedule-input subtitle1 gray400" type="number" max="59" min="0" maxlength="2" name="lnk_time" placeholder="분" value="0">
                                    <span class="subtitle1 gray500">분</span>
                                    <input class="schedule-input subtitle1 gray400" type="number" max="23" min="0" maxlength="2" name="lnk_time" placeholder="시간" value="0">
                                    <span class="subtitle1 gray500">시간</span>
                                    <input class="schedule-input subtitle1 gray400" type="number" max="31" min="0" maxlength="2" name="lnk_time" placeholder="일" value="0">
                                    <span class="subtitle1 gray500">일</span>
                                    <input class="schedule-input subtitle1 gray400" type="number" max="12" min="0" maxlength="2" name="lnk_time" placeholder="월" value="0">
                                    <span class="subtitle1 gray500">월</span>
                                    <input class="schedule-input subtitle1 gray400" type="number" max="6" min="0" maxlength="1" name="lnk_time" placeholder="요일" value="0">
                                    <span class="subtitle1 gray500">요일</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="link-table-box-top-right">
                        <div class="flag-box">
                            <div class="flag-title body1 gray500 bg-gray200 border-gray300">연계플래그 타입</div>
                            <div class="flag-radio-box subtitle1 gray400">
                                <div>
                                    <label><input type="radio" name="flag_type" value="STATUS" checked="checked">STATUS</label>
                                </div>
                                <div>
                                    <label><input type="radio" name="flag_type" value="QUERY">QUERY</label>
                                </div>
                                <div>
                                    <label><input type="radio" name="flag_type" value="WHERE">WHERE</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="common-input-box" id="flagTypeBoxWhere">
                    <div class="header6 label-title">WHERE</div>
                    <input class="common-input subtitle1 gray400" id="flagTypeInputWhere" type="text" name="" placeholder="조건문을 입력하세요">
                </div>
                <div class="common-input-box" id="flagTypeBoxQuery">
                    <div class="header6 label-title">조회쿼리</div>
                    <input class="common-input subtitle1 gray400" id="flagTypeInputQuery" type="text" name="" placeholder="쿼리를 입력하세요">
                </div>
                <div class="link-table-box-bottom">
                    <table class="link-table-list">
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
                                <td id="column_1">COLUMN1</td>
                                <td>VARCHAR2(100)</td>
                                <td>timestamp();</td>
                                <td>
                                    <input class="tdIsConnect" type="checkbox" name="connect_use_yn" id="use_yn_column_1" onclick="colUseCheck()">
                                </td>
                                <td>
                                    <select class="tdLinkSelect">
                                        <option value="1">STATUS</option>
                                        <option value="2">QUERY</option>
                                        <option value="3">WHERE</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="table-spacing"></tr>
                            <tr class="subtitle1 gray500">
                                <td class="column_2">COLUMN2</td>
                                <td>VARCHAR2(100)</td>
                                <td>timestamp();</td>
                                <td>
                                    <input class="tdIsConnect" type="checkbox" name="connect_use_yn" id="use_yn_column_2" onclick="colUseCheck()">
                                </td>
                                <td>
                                    <select class="tdLinkSelect">
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
                <div id="queryResult" class="query-text subtitle1 gray400 bg-gray200 border-gray300"></div>
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

            $('#flagTypeBoxQuery').css('display', 'none');
            $('#flagTypeBoxWhere').css('display', 'none');
        });

        function colUseCheck() {
            const use_yn = $("#use_yn").val;
            console.log("@@@@@@@@@@@@" + use_yn);
        }

        // 연계플래그 타입 선택에 따른 onChange Event
        $('input[name="flag_type"]').on('change', function () {
            let currentType = $(this).val();
            const queryType = '#flagTypeBoxQuery';
            const whereType = '#flagTypeBoxWhere';

            $(queryType).css('display', currentType === 'QUERY' ? 'block' : 'none');
            $(whereType).css('display', currentType === 'WHERE' ? 'block' : 'none');

            $('#flagTypeInputQuery, #flagTypeInputWhere').val('');
            $('#queryResult').text('')

            if (currentType === 'QUERY') {
                $('.tdIsConnect, .tdLinkSelect').css('display', 'none');
            } else if (currentType === 'WHERE') {
                $('.tdLinkSelect').css('display', 'none');
                $('.tdIsConnect').css('display', 'inline-block');
                $('#queryResult').text('SELECT * WHERE ');
            } else {
                $('.tdIsConnect, .tdLinkSelect').css('display', 'inline-block');
            }
        })
        //연계플래그 input 입력 시 조회쿼리 TEXT로 적용되는 함수
        $('#flagTypeInputQuery').on('input', function () {
            $('#queryResult').text($(this).val());
        });
        $('#flagTypeInputWhere').on('input', function () {
            var selectColumn = '';

            $('input[name="connect_use_yn"]:checked').each(function () {
                var inputId = $(this).attr('id');
                var columnName = $('#' + inputId.substring(7)).text()

                selectColumn += columnName;
            });

            if (selectColumn === '') {
                selectColumn = '*';
            }
            $('#queryResult').text('SELECT ' + selectColumn + ' WHERE ' + $(this).val());
        });

        //크론탭 가이드
        $(".guide-icon").on({
            mouseenter: function () {
                $('.guide-box').css('display', 'block');
                $('.guide-box').text(
                    '쿼리가 실행되는 주기를 설정할 수 있습니다.\n' +
                    '\n' +
                    ' 분 : 1-59,\n' +
                    ' 시간 : 1-23,\n' +
                    ' 날짜 : 1-31,\n' +
                    ' 월 : 1-12,\n' +
                    ' 요일 : 0-6\n' +
                    '(일요일 = 0)');
            },
            mouseleave: function () {
                $('.guide-box').css('display', 'none');
            },
        })

    </script>

</section>