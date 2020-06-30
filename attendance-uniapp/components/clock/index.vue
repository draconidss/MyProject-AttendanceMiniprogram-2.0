<template name="clock">
    <view class="content">

        <view class="flip-container">
            <view class="flip-items" v-for="(unit,unitIndex) of timeArr" :key="unitIndex">
                <view class="item" v-for="(item,index) of unit.max + 1" :key="index" 
                    :class="{current: unit.current == index, past: unit.current - 1 == index || index==unit.max&&unit.current==0}">
                    <view class="up">
                        <view class="inner">{{index}}</view>
                        <view class="shadow"></view>
                    </view>
                    <view class="down">
                        <view class="inner">{{index}}</view>
                        <view class="shadow"></view>
                    </view>
                </view>
            </view>
        </view>
        <!-- <navigator url="../fliqlo/fliqlo" class="other">查看其它示例</navigator> -->
    </view>
</template>

<script>
    function getTimeStr(){
        let time = new Date();
        let hour = ('00' + time.getHours()).slice(-2)
        let minute = ('00' + time.getMinutes()).slice(-2)
        let second = ('00' + time.getSeconds()).slice(-2)
        let timeStr = hour + minute + second
        return timeStr
    }
	export default {
		data() {
			return {
                timeStr:getTimeStr(),
                timeRunner:''
			}
		},
        computed:{
            timeArr(){
                return [...this.timeStr].map((unit,index)=>{
                    let max;
                    if(index&1==1){     //时分秒的个位
                        max = 9
                    }else if(index==0){ //时十位
                        max = 2
                    }else if(index==2){ //分十位
                        max = 5
                    }else if(index==4){ //秒十位
                        max = 5
                    }
                    return {
                        max,
                        current:Number(unit),
                    }
                })
            }
        },
        methods:{
            setTimeRunner(){
                this.timeRunner = setInterval(()=>{
                    this.timeStr = getTimeStr()
                },1000)
            }
        },
		created() {
            this.setTimeRunner()
		},
        beforeDestroy() {
            clearInterval(this.timeRunner)
        },
	}
</script>

<style>
    html,body,page{
        font: normal "Helvetica Neue", Helvetica, sans-serif;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
<style lang="stylus">
    $width = 60rpx;
    $backgroundColor = #333
    $color = #ccc
    $time = 1s
    $height = $width * 1.5;
    $fontSize = $width * 1.3;
    $lineWidth = ($width / 60);
    $radius = ($width / 10);
    $perspective = $width * 5;
    $gap= $width * 0.2
    .flip-container
        display flex
        justify-content center
        padding 0 20rpx
        position relative
        .flip-items
            // margin 50rpx auto
            position relative
            width $width
            height $height
            font-size $fontSize
            font-weight bold
            border-radius $radius
            box-shadow: 0 2rpx 18rpx rgba(0, 0, 0, 0.7)
            &:nth-of-type(2n+1)
                margin-right $gap
            &:nth-of-type(2),&:nth-of-type(4)
                margin-right $gap * 3
                &::after,&::before
                    position absolute
                    right -(@margin-right / 2)
                    content ''
                    transform translateX(50%)
                    width ($gap / 1.5)
                    height @width
                    border-radius 50%
                    background-color $backgroundColor
                &::before
                    top 25%
                &::after
                    bottom 25%
            .item
                z-index 1
                position absolute
                top 0
                left 0
                right 0
                bottom 0
                perspective $perspective
                &:before
                    content: ''
                    position absolute
                    top (($height - $lineWidth) / 2)
                    left 0
                    z-index 9
                    width: 100%
                    height: $lineWidth
                    min-height 2px
                    background-color rgba(0, 0, 0, 0.6)
                    // background-color $backgroundColor
                .up,.down
                    position absolute;
                    left 0;
                    right 0
                    height 50%;
                    overflow hidden
                .up
                    transform-origin 50% 100%
                    top 0
                .down
                    transform-origin 50% 0%
                    bottom 0
                .inner 
                    position: absolute;
                    left: 0;
                    width: 100%;
                    height: $height
                    line-height $height
                    color: $color;
                    text-shadow: 0 2rpx 4rpx #000
                    text-align: center;
                    background-color: $backgroundColor
                    border-radius: $radius
                .up .inner 
                    top 0
                .down .inner 
                    bottom 0
                .up .shadow
                    border-top-left-radius $radius
                    border-top-right-radius $radius
                .down .shadow
                    border-bottom-left-radius $radius
                    border-bottom-right-radius $radius
        .flip-items .item
            &.past {
              z-index: 3;
            }
            &.current {
              //反转到中间时候当前秒层级最大
              animation: highter-level ($time/2) ($time/2) linear forwards;
              z-index: 2;
            }
            &.past .up {
              animation: flip-past-up ($time/2) linear both;
            }
            &.current .down {
              animation: flip-current-down ($time/2) ($time/2) linear both;
            }
            @keyframes flip-current-down {
              from{
                transform: rotateX(90deg);
              }
              to {
                transform: rotateX(0deg);
              }
            }
            @keyframes flip-past-up {
              from{
                transform: rotateX(0deg);
              }
              to {
                transform: rotateX(-90deg);
              }
            }    
            @keyframes highter-level {
              from{
                z-index: 4;
              }
              to {
                z-index: 4;
              }
            }
        // 控制阴影
        .flip-items .item
            .shadow {
              position: absolute;
              width: 100%;
              height: 100%;
            }
            &.past .up .shadow {
              background: linear-gradient(rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 1) 100%);
              animation: show ($time/2) linear both;
            }
            &.past .down .shadow {
              background: linear-gradient(rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.1) 100%);
              animation: show ($time/2) linear both;
            }
            &.current .up .shadow {
              background: linear-gradient(rgba(0, 0, 0, 0.1) 0%, rgba(0, 0, 0, 1) 100%);
              animation: hide ($time/2) 0.3s linear both;
            }
            &.current .down .shadow {
              background: linear-gradient(rgba(0, 0, 0, 1) 0%, rgba(0, 0, 0, 0.1) 100%);
              animation: hide ($time/2) 0.3s linear both;
            }
        
        @keyframes show {
          from{
            opacity: 0;
          }
          to {
            opacity: 1;
          }
        }
        @keyframes hide {
          from{
            opacity: 1;
          }
          to {
            opacity: 0;
          }
        }
    .other
        position absolute
        font-size 26px
        left 50%
        transform translateX(-50%)
        bottom 50rpx
</style>
