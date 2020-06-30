<template>
	<view>
		<u-toast ref="uToast" />


		<!-- 返回顶部 -->
		<u-back-top @tap="toTop" :scroll-top="scrollTop" mode="square" top="20" right="28" bottom="90"></u-back-top>

		<!-- <drag-button :isDock="true" :existTabBar="true" @btnClick="showCale" style="z-index: 20;">
			<view slot="icon" class="text-xxl">
				<text class=" cuIcon-calendar "></text>
			</view>
		</drag-button> -->

		<u-calendar v-model="isCale" mode="range" safeAreaInsetBottom="true" @change="getLogAndDuration" :closeable="false">
			<view slot="tooltip" style="text-align: center;">
				<u-button type="primary" size="default" :ripple="true" @click="getLogAndDuration2">查看所有</u-button>
			</view>
		</u-calendar>



		<!-- 日志抽屉主界面 -->
		<scroll-view style="background-color: white;" scroll-y class="DrawerPage" :class="modalName=='showRoomLog'?'show':''" :scroll-top="scrollTop" @scroll="scroll">




			<u-sticky>
				<!-- 顶部栏 -->
				<u-navbar title="我的日志" :background="{ background: '#00152a' }" is-fixed="true" title-size="40" :is-back="false"
				 title-color="#ffffff">
					<view class="slot-wrap shadow-blur">
						<view class="margin-left-sm" @tap="showCale">
							<u-icon name="calendar" color="#ffffff" size="60"></u-icon>
						</view>
					</view>
				</u-navbar>
				<!-- 总览 -->
				<view class="cu-list grid col-2">
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-xxl text-black">
								<u-count-to :start-val="0" :end-val="Math.floor(allDuration/1000/3600) " :duration="1500" :use-easing="true"
								 ref="uCountTo1" :autoplay="false" bold="true" color="#0081ff"></u-count-to>h
								<u-count-to :start-val="0" :end-val="Math.floor(allDuration/1000/60%60) " :duration="1500" :use-easing="false"
								 ref="uCountTo2" :autoplay="false" bold="true" color="#0081ff"></u-count-to>m
							</view>
							<view class="margin-top-xs text-sm text-gray">总时长</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-xxl text-black">

								<u-count-to :start-val="0" :end-val="logList_Len" :duration="1500" :use-easing="true" ref="uCountTo3" :autoplay="false"
								 bold="true" color="#e54d42"></u-count-to>

							</view>
							<view class="margin-top-xs text-sm text-gray">总日志</view>
						</view>
					</view>
				</view>

				<u-subsection :bold="true" :list="tabsList" :current="currentTabs" @change="tabsChange" button-color="#0081ff"
				 active-color="white"></u-subsection>
				 
				 <!-- 实名提醒 -->
				 <view class="cu-list card-menu margin-top shadow-warp " v-if="userInfo == null">
				 	<u-cell-group>
				 		<navigator url="../profile/profile" open-type="switchTab">
				 			<u-cell-item :arrow="true" title="请先实名手机绑定再查看自己的日志">
				 				<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
				 			</u-cell-item>
				 		</navigator>
				 	</u-cell-group>
				 </view>

				<view class="shadow bg-blue" v-else>
					<u-cell-group v-if="currentTabs == 1">
						<u-cell-item :title="'我一共去过的实验室数量为'+roomDurationList.length+'间'" arrow-direction="down" :arrow="true">
							<view slot="icon" class="cuIcon-discover padding-right-sm padding-bottom-lg text-blue"></view>
						</u-cell-item>
					</u-cell-group>

					<u-cell-group v-else-if="currentTabs == 0">
						<u-cell-item :title="'从'+startDate+'到'+endDate" :label="'时长'+Math.floor(allDuration2/1000/3600)+'时'+Math.floor(allDuration2/1000/60%60)+'分,共'+logList_Len2+'条日志'"
						 :arrow="false" @tap="showCale" v-if="startDate!=null&&endDate!=null">
							<view slot="icon" class="cuIcon-calendar padding-right-sm padding-bottom-lg text-blue"></view>
							<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="showCale">日期筛选</u-button>
						</u-cell-item>

						<navigator url="../home/home" open-type="switchTab" v-if="logList.length == 0">
							<u-cell-item title="您还没有日志记录,试着去进入一个实验室吧" :arrow="true" icon="warning">
							</u-cell-item>
						</navigator>
					</u-cell-group>

				</view>

			</u-sticky>

			

			<!-- 日志表 -->
			<block v-if="currentTabs == 0">
				<u-empty text="还没有日志" mode="message" v-if="logList.length == 0"></u-empty>
				<block v-else>
				<view class="cu-timeline" >
					<view class="text-bold text-xxl padding-left-sm">2020</view>
					<block v-for="(item,index) in logList" :key="index">
						<view class="cu-item " :class="item.status==1?'cuIcon-attentionfill text-green':'cuIcon-attentionforbidfill text-blue'">
							<view class="cu-capsule radius shadow">
								<view class="cu-tag sm" :class="item.status==1?'bg-green':'bg-blue'">{{item.ldate | duration()}}</view>
								<view class="cu-tag  sm" :class="item.status==1?'line-green':'line-blue'">{{item.ldate | dataFormat("MD")}}{{' '}}{{item.ldate | dataFormat("Hm")}}</view>
							</view>
							<view class="cu-capsule radius shadow-blur" v-if="item.during">
								<view class="cu-tag bg-blue sm">时长</view>
								<view class="cu-tag line-blue sm">{{item.during | dataFormat("duration")}}</view>
							</view>

							<view class=" shadow-blur solids" :class="item.status==1?'bg-green':'bg-blue'">
								<u-cell-group class=" shadow-lg">
									<u-cell-item :arrow="false">
										<view slot="title" class="text-black text-bold text-sm padding">{{item.user.realName}}通过指纹{{item.status==1?'进入':'离开'}}

										</view>
										<view slot="icon" class="cu-avatar radius shadow" :class="item.status==1?'bg-green':'bg-blue'">
											{{item.status==1?'进':'出'}}
										</view>

										<view class="cu-capsule radius shadow-blur" slot="right-icon">
											<view class="cu-tag sm " :class="item.status==1?'bg-green':'bg-blue'"><text class='cuIcon-location'></text></view>
											<view class="cu-tag  sm" :class="item.status==1?'line-green':'line-blue'">{{item.room.rname}}</view>
										</view>
									</u-cell-item>

								</u-cell-group>
							</view>
						</view>
					</block>
				</view>
				<u-divider half-width="250">没有更多了</u-divider>
				</block>

			</block>



			<!-- 我的实验室 -->
			<view v-if="currentTabs == 1" class="padding-top-lg">
				<u-empty text="您还没去过实验室" mode="list" v-if="roomDurationList.length == 0"></u-empty>
				<block v-else>
					<view class="cu-card ">

						<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
						 v-for="(item,index) in roomDurationList" style="height: 180upx;" :key="index" @click="showRoomLogModal"
						 data-modal="showRoomLog" :data-rid="item.rid" :data-rname="item.rname">
							<navigator>
								<view class="flex solid-bottom justify-between">
									<view class="padding-left-xl padding-top-sm text-white">
										<view class=" text-xxl text-bold">
											{{item.rname}}
										</view>
										<view class="padding-top-xs text-lg">

											<u-button type="success" :ripple="true" size="mini">共{{item.logCount}}条日志</u-button>
											<u-button type="primary" :ripple="true" size="mini" class="padding-left-sm" v-if="item.roomDuring">时长:{{item.roomDuring | dataFormat("duration")}}</u-button>
											<u-button type="primary" :ripple="true" size="mini" class="padding-left-sm" v-else>时长:0时0分</u-button>


										</view>
									</view>
									<u-tag text="常去" type="success" mode="dark" v-if="index == 0 || index == 1" />
								</view>
							</navigator>
						</view>

					</view>

				</block>
			</view>

			<!-- 获取状态加载条 -->
<!-- 			<view class="load-progress" :class="loadProgress_data!=0?'show':'hide'" :style="[{top:CustomBar+'px'}]">
				<view class="load-progress-bar bg-green" :style="[{transform: 'translate3d(-' + (100-loadProgress) + '%, 0px, 0px)'}]"></view>
				<view class="load-progress-spinner text-green"></view>
			</view> -->



		</scroll-view>

		<!-- 从抽屉返回主页面 -->
		<view class="DrawerClose" :class="modalName=='showRoomLog'?'show':''" @tap="hideModal">
			<text class="cuIcon-pullright"></text>
		</view>



		<!-- 抽屉界面，房间日志 -->
		<scroll-view scroll-y class="DrawerWindow bg-white" :class="modalName=='showRoomLog'?'show':''" >

			<view class="cu-bar justify-center bg-white">
				<view class="action border-title">
					<text class="text-xl text-bold text-blue">在{{roomLogList[0].room.rname}}有{{roomLogList.length}}条日志</text>
					<text class="bg-gradual-blue" style="width:10rem"></text>
				</view>
			</view>


			<!-- 			<view class="cu-bar justify-center bg-white" style="position: fixed;top: 50;width: 100%;z-index: 9999;">
					<u-cell-group >
						<u-cell-item :title="'我在'+roomLogList[0].room.rname+'的日志有'+roomLogList.length+'条'" arrow-direction="down" :arrow="true" >
							<view slot="icon" class="cuIcon-calendar padding-right-sm padding-bottom-lg text-blue "></view>
						</u-cell-item>
					</u-cell-group>
			</view> -->


			<!-- 			<cu-custom >
				<block slot="content"><text class="text-white"> {{roomLogList[0].room.rname}}</text></block>
			</cu-custom>

				<u-cell-group >
					<u-cell-item :title="'我在'+roomLogList[0].room.rname+'的日志有'+roomLogList.length+'条'" arrow-direction="down" :arrow="true" >
						<view slot="icon" class="cuIcon-calendar padding-right-sm padding-bottom-lg text-blue "></view>
					</u-cell-item>
				</u-cell-group> -->

			<view class="cu-timeline">
				<view class="text-bold text-xxl padding-left-sm">2020</view>
				<block v-for="(item,index) in roomLogList" :key="index">
					<view class="cu-item " :class="item.status==1?'cuIcon-attentionfill text-green':'cuIcon-attentionforbidfill text-blue'">
						<view class="cu-capsule radius shadow">
							<view class="cu-tag sm" :class="item.status==1?'bg-green':'bg-blue'">{{item.ldate | duration()}}</view>
							<view class="cu-tag  sm" :class="item.status==1?'line-green':'line-blue'">{{item.ldate | dataFormat("MD")}}{{' '}}{{item.ldate | dataFormat("Hm")}}</view>
						</view>
						<view class="cu-capsule radius shadow-blur" v-if="item.during">
							<view class="cu-tag bg-blue sm">时长</view>
							<view class="cu-tag line-blue sm">{{item.during | dataFormat("duration")}}</view>
						</view>

						<view class=" shadow-blur solids" :class="item.status==1?'bg-green':'bg-blue'">
							<u-cell-group class=" shadow-lg">
								<u-cell-item :arrow="false">
									<view slot="title" class="text-black text-bold text-sm padding-left-sm">{{item.user.realName}}通过指纹{{item.status==1?'进入':'离开'}}</br>
										<view class="cu-capsule radius shadow-blur">
											<view class="cu-tag sm " :class="item.status==1?'bg-green':'bg-blue'"><text class='cuIcon-location'></text></view>
											<view class="cu-tag  sm" :class="item.status==1?'line-green':'line-blue'">{{item.room.rname}}</view>
										</view>

									</view>
									<view slot="icon" class="cu-avatar radius shadow" :class="item.status==1?'bg-green':'bg-blue'">
										{{item.status==1?'进':'出'}}
									</view>


								</u-cell-item>

							</u-cell-group>
						</view>
					</view>
				</block>
			</view>






			<u-divider half-width="250">没有更多了</u-divider>


		</scroll-view>




	</view>
</template>

<script>
	import moment from 'moment'
	export default {
		data() {
			return {
				// 进度条
				loadProgress_data: 0,
				CustomBar: this.CustomBar,
				startDate: null,
				endDate: null,
				isCale: false,
				scrollTop: 0,
				old: {
					scrollTop: 0
				},
				scrollTop2: 0,
				modalName: null,
				wxuserInfo: null,
				userInfo: null,
				logList: null,
				logList_Len: 0,
				allDuration: 0,
				logList_Len2: 0,
				allDuration2: 0,
				roomDurationList: null,
				roomLogList: null,
				currentTabs: 0,
				tabsList: [{
					name: '我的日志'
				}, {
					name: '去过的实验室'
				}],
			}
		},

		onShow() {

			var that = this
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			// global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")

			if (that.userInfo != null) {
				var e = {}
				e.startDate = null
				e.endDate = null
				that.getLogAndDuration(e)
			}

		},

		methods: {

			// 打开日期筛选
			showCale() {
				this.isCale = true
			},
			// 选择时间段后
			caleChange(e) {
				var that = this
				that.getLogAndDuration(e)

			},
			toTop(){
				var that = this
				that.scrollTop = that.old.scrollTop
				that.$nextTick(function() {
					that.scrollTop = 0
				});
			},
			scroll: function(e) {
				this.old.scrollTop = e.detail.scrollTop
			},
						
			// 监听滚动条
/* 			scroll(e) {
				this.scrollTop = e.detail.scrollTop
			}, */
			// 打开modal
			showModal(e) {
				this.modalName = e.currentTarget.dataset.modal
			},
			hideModal(e) {
				this.modalName = null
			},
			// tabs栏切换
			tabsChange(index) {
				var that = this
				that.currentTabs = index;
				if (index == 0) {
					var e = {}
					e.startDate = null
					e.endDate = null
					that.getLogAndDuration(e)
				} else if (index == 1) {
					that.getMyRoom()
				}


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
			// 加载进度条
			loadProgress() {
				if (this.loadProgress_data < 100) {
					setTimeout(() => {
						this.loadProgress();
					}, 50)
				} else {
					this.loadProgress_data = 0;
				}
			},

			// 获取此人所有时长，房间日志等
			getLogAndDuration(e) {
				uni.showLoading({
					title: '正在加载日志'
				})
				var that = this
				
				that.toTop()
				var startDate = e.startDate
				var endDate = e.endDate
				if(that.userInfo!=null){
					uni.request({
						url: "http://47.100.59.153:8885/MP/log/getLog",
						data: {
							uid: that.userInfo.uid
						},
						success(res) {
							console.log(res)
							that.logList = res.data.logList
					
							if (startDate != null && endDate != null) {
								var allDuration2 = 0
								console.log("选择日期模式")
								var logList_2 = []
								for (let i = 0; i < that.logList.length; i++) {
									let ldate = moment(that.logList[i].ldate).format('YYYY-MM-DD')
									if (moment(ldate).isBefore(startDate) == false && moment(ldate).isAfter(endDate) == false) {
										console.log("符合条件" + that.logList[i])
										logList_2.push(that.logList[i])
										if (that.logList[i].during != null) {
											allDuration2 = allDuration2 + that.logList[i].during
										}
									}
								}
								that.logList = logList_2
								that.logList_Len2 = that.logList.length
								that.allDuration2 = allDuration2
								that.startDate = startDate
								that.endDate = endDate
								that.currentTabs = 0
								
								that.showToast("获取从" + startDate + "到" + endDate + "的日志成功", "success", "bottom")
							}
							// 获取全部
							else {
								var allDuration = 0
								for (let i = 0; i < that.logList.length; i++) {
									allDuration = allDuration + that.logList[i].during
								}
								that.startDate = moment(that.logList[that.logList.length - 1].ldate).format('YYYY-MM-DD')
								that.endDate = moment(that.logList[0].ldate).format('YYYY-MM-DD')
								that.$refs.uCountTo1.start();
								that.$refs.uCountTo2.start();
								that.$refs.uCountTo3.start();
								that.logList_Len = that.logList.length
								that.allDuration = allDuration
								that.logList_Len2 = that.logList.length
								that.allDuration2 = allDuration
								that.showToast("获取日志成功", "success", "bottom")
							}
							that.isCale = false
							that.scrollTop = 0
							
						}
					})
				}

				uni.hideLoading()
			},
			getLogAndDuration2() {
				var that = this
				var e = {}
				e.startDate = null
				e.endDate = null
				that.toTop()
				that.getLogAndDuration(e)
			},
			getMyRoom() {
				uni.showLoading({
					title: '加载我去过的实验室'
				})
				var that = this
				if (that.userInfo != null) {
					uni.request({
						url: "http://47.100.59.153:8885/MP/log/getDuration?uid=1",
						data: {
							uid: that.userInfo.uid
						},
						success(res) {
							console.log(res)
							that.roomDurationList = res.data.roomDurationList
							that.showToast("获取去过的实验室成功", "success", "bottom")
						}
					})					
				}
				uni.hideLoading()
			},
			// 获取某人在某间房间的日志
			showRoomLogModal(e) {
				var that = this
					uni.showLoading({
						title:"正在获取日志"
					})
					that.modalName = e.currentTarget.dataset.modal
					var rid = e.currentTarget.dataset.rid
					var rname = e.currentTarget.dataset.rname
					uni.request({
						url: "http://47.100.59.153:8885/MP/log/getLog",
						data: {
							uid: that.userInfo.uid,
							rid: rid
						},
						success(res) {
							console.log(res)
							that.roomLogList = res.data.logList
							that.showToast("获取我在" + rname + "的日志成功", "success", "bottom")
						}
					})
					uni.hideLoading()

			}


		}
	}
</script>

<style>
	.slot-wrap {
		display: flex;
		align-items: center;
		flex: 1;
	}

	.u-node {
		width: 44rpx;
		height: 44rpx;
		border-radius: 100rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		background: #d0d0d0;
	}

	.u-order-title {
		color: #333333;
		font-weight: bold;
		font-size: 32rpx;
	}

	.u-order-desc {
		color: rgb(150, 150, 150);
		font-size: 28rpx;
		margin-bottom: 6rpx;
	}

	.u-order-time {
		color: rgb(200, 200, 200);
		font-size: 26rpx;
	}

	.cardTitle {
		color: #fff;
		padding: 90upx 60upx;
		font-size: 40upx;
		font-weight: 300;
		transform: skew(-10deg, 0deg);
		position: relative;
		text-shadow: 0px 0px 6upx rgba(0, 0, 0, 0.3)
	}

	/* 抽屉样式 */
	.DrawerPage {
		position: absolute;
		width: 100vw;
		height: 100vh;
		left: 0vw;
		background-color: #f1f1f1;
		transition: all 0.4s;
	}

	.DrawerPage.show {
		transform: scale(0.9, 0.9);
		left: 85vw;
		box-shadow: 0 0 60upx rgba(0, 0, 0, 0.2);
		transform-origin: 0;
	}

	.DrawerWindow {
		position: absolute;
		width: 85vw;
		height: 100vh;
		left: 0;
		top: 0;
		transform: scale(1, 1) translateX(-100%);
		opacity: 0;
		pointer-events: none;
		transition: all 0.4s;
		padding: 55upx 0;
	}

	.DrawerWindow.show {
		transform: scale(1, 1) translateX(0%);
		opacity: 1;
		pointer-events: all;
	}

	.DrawerClose {
		position: absolute;
		width: 40vw;
		height: 100vh;
		right: 0;
		top: 0;
		color: transparent;
		padding-bottom: 600upx;
		display: flex;
		align-items: flex-end;
		justify-content: center;
		background-image: linear-gradient(90deg, rgba(0, 0, 0, 0.01), rgba(0, 0, 0, 0.6));
		letter-spacing: 5px;
		font-size: 50upx;
		opacity: 0;
		pointer-events: none;
		transition: all 0.4s;
	}

	.DrawerClose.show {
		opacity: 1;
		pointer-events: all;
		width: 15vw;
		color: #fff;
	}

	.DrawerPage .cu-bar.tabbar .action button.cuIcon {
		width: 64upx;
		height: 64upx;
		line-height: 64upx;
		margin: 0;
		display: inline-block;
	}

	.DrawerPage .cu-bar.tabbar .action .cu-avatar {
		margin: 0;
	}

	.DrawerPage .nav {
		flex: 1;
	}

	.DrawerPage .nav .cu-item.cur {
		border-bottom: 0;
		position: relative;
	}

	.DrawerPage .nav .cu-item.cur::after {
		content: "";
		width: 10upx;
		height: 10upx;
		background-color: currentColor;
		position: absolute;
		bottom: 10upx;
		border-radius: 10upx;
		left: 0;
		right: 0;
		margin: auto;
	}

	.DrawerPage .cu-bar.tabbar .action {
		flex: initial;
	}
</style>
