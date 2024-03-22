<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
    .banner-box{
        width: 100%;
        height: 280px;
        position: relative;
        z-index: 999;
    }
    .banner-title-box{
        position: absolute;
        top: 86px;
        left: 50%;
        z-index: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .banner-title{
        margin-bottom: 8px;
    }
</style>

<body>
    <div class="banner-box" >
        <img src="/img/img-banner-sm.png" alt="배너">
        <div class="banner-title-box">
            <div class="banner-title header1 white80"></div>
            <div class="banner-sub-title subtitle1 white100"></div>
        </div>
    </div>
</body>

