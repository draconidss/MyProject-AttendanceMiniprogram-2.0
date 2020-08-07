<template>
	<view>
		<!-- toast提示 -->
		<u-toast ref="uToast" />

		<u-back-top :scroll-top="scrollTop" mode="square" top="0" bottom="20"></u-back-top>

		<u-sticky offset-top="100" z-index="-1">
			<view class="bg-img bg-mask flex align-center shadow-blur" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/rank'+currentTab+'.jpeg)'}"
			 style="height: 400upx;">
				<view class=" text-white" style="padding-top: 100rpx;">
					<view class=" margin-left-lg flex align-center">
						<view class="cu-avatar radius shadow" :style="{backgroundImage:'url('+topUser.avatarUrl+')'}"></view>
						<view class=" text-xxl text-bold">
							{{topUser.nickName}}目前占领了{{currentTab == 0?'本周':'本月'}}的封面
						</view>

					</view>

					<view class="padding-sm padding-top-lg text-lg">
						<u-button type="primary" :ripple="true" size="medium" :plain="true" class="padding-left-sm">{{topUser_allDur}}</u-button>
					</view>
				</view>
			</view>





			<!-- 		<view class="cu-bar justify-center bg-white">
			<view class="action border-title">
				<text class="text-df text-bold text-blue">更新于{{moment().locale('zh-cn').format('YYYY-MM-DD HH:mm:ss')}}</text>
				<text class="bg-gradual-blue" style="width:8rem"></text>
			</view>
		</view> -->

			<!-- 		<u-cell-group>
				<u-cell-item  :title="'更新于'+moment().locale('zh-cn').format('YYYY-MM-DD HH:mm:ss')"  :arrow="false">
					<u-icon slot="icon" size="33" name="clock"  ></u-icon>
				</u-cell-item>
			</u-cell-group> -->

			<u-subsection :bold="true" :list="tabsList" :current="currentTab" @change="tabsChange" button-color="#0081ff"
			 active-color="white"></u-subsection>

		</u-sticky>

		<!-- 实名判定 -->

		<u-cell-group class="margin-top shadow-lg">
			<navigator url="../profile/profile" open-type="switchTab" v-if="!userInfo">
				<u-cell-item :arrow="true" title="您还未实名手机绑定,无法查看自己排行榜">
					<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
				</u-cell-item>
			</navigator>

			<block v-else>
				<u-cell-item :arrow="false" v-for="(item,index) in durationList" :key="index" bg-color="#00152a" v-if="item.uid == userInfo.uid">
					<view slot="title" class="text-white text-bold text-lg padding-top-xs">我的({{item.realName}})</view>
					<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item.avatarUrl+')'}"></view>
					<view slot="right-icon" class="text-white text-bold text-lg">{{item.allDuration | dataFormat("duration")}}</view>
				</u-cell-item>
			</block>
		</u-cell-group>




		<!-- <view class="cu-list card-menu margin-top shadow-warp" > -->
		<u-cell-group class="margin-top shadow-lg">

			<u-cell-item :arrow="false" v-for="(item,index) in durationList" :key="index">
				<view slot="title" class="text-black text-bold text-lg padding-top-xs">{{item.realName}}({{item.nickName}})</view>
				<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item.avatarUrl+')'}">
					<view class="cu-tag badge lg">{{index+1}}</view>
				</view>
				<view slot="right-icon" class="text-black text-bold text-lg">{{item.allDuration | dataFormat("duration")}}</view>
			</u-cell-item>

		</u-cell-group>




	</view>
</template>

<script>
	export default {
		data() {
			return {
				scrollTop: 0,
				wxuserInfo: null,
				userInfo: null,
				// rank数据
				durationList: null,
				roomDurationList: null,
				currentTab: 0,
				topUser: null,
				topUser_allDur: null,
				tabsList: [{
					name: '本周'
				}, {
					name: '本月'
				}]
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onShow() {
			uni.showShareMenu({
				withShareTicket: true,
				menus: ['shareAppMessage', 'shareTimeline']
			})


			var that = this
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")
			console.log("rank里的userInfo" + that.userInfo)
			that.getRank()
		},

		onShareAppMessage: function() {
			return {
				title: "查看实验室活跃度",
				path: '/pages/rank/rank'
			}

		},

		onShareTimeline: function() {
			return {
				title: "查看实验室活跃度",
				imageUrl: "https://mp.weixin.qq.com/wxopen/qrcode?action=show&type=2&fakeid=3828130167&token=1611511643"
			}
		},

		methods: {
			tabsChange(index) {
				var that = this
				that.currentTab = index
				that.getRank()
			},
			// toast提示
			showToast(title, type, position) {
				this.$refs.uToast.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			},
			getRank() {
				uni.showLoading({
					title: "获取活跃度中"
				})
				var that = this
				var duration
				if (that.currentTab == 0) {
					duration = 1
				} else {
					duration = 2
				}

				uni.request({
					url: "https://api.attendance.lifeisgg.online/MP/rank/getRank",
					data: {
						duration: duration
					},
					success(res) {
						console.log(res)
						that.durationList = res.data.durationList
						that.roomDurationList = res.data.roomDurationList
						that.topUser = that.durationList[0]

						var h = Math.floor(that.topUser.allDuration / 1000 / 60 / 60);
						var m = Math.floor(that.topUser.allDuration / 1000 / 60 % 60);
						that.topUser_allDur = h + "时" + m + "分"
						if (duration == 1) {
							that.showToast("获取本周排行榜成功", "success", "bottom")
						} else if (duration == 2) {
							that.showToast("获取本月排行榜成功", "success", "bottom")
						}
						setTimeout(function() {
							uni.hideLoading()
						}, 500);

					}
				})

			}
		}
	}
</script>

<style>

</style>
