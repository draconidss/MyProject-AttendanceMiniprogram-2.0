<template>
	<view>
		<u-toast ref="uToast" />


		<!-- 		<view class="cu-modal show" v-if="!statusInfo">
			<view class="cu-dialog" >
				<u-button type="success" :loading="enterRoomLoading" :ripple="true" @click="getRoomList">
					<u-icon name="map" size="40" style="margin-right:10rpx ;"></u-icon>点击模拟进入实验室
				</u-button>
				<u-select  v-model="showSelectRoom" mode="single-column" :list="roomList" @confirm="inRoom"></u-select>
			</view>				
		</view> -->



		<!-- 离开实验室 -->





		<!-- 获取状态加载条 -->
		<view class="load-progress" :class="loadProgress!=0?'show':'hide'" :style="[{top:CustomBar+'px'}]">
			<view class="load-progress-bar bg-green" :style="[{transform: 'translate3d(-' + (100-loadProgress) + '%, 0px, 0px)'}]"></view>
			<view class="load-progress-spinner text-green"></view>
		</view>

		<u-mask :show="true" @click="show = false" :mask-click-able="false" v-if="statusInfo==null" z-index="20">

			<u-toast ref="uToastMask" />
			<view style="display: flex;	align-items: center;	justify-content: center;height: 100%;width: 100%;">

				<u-button type="warning" :ripple="true" @click="toRealName" v-if="userInfo==null">
					<u-icon name="warning" size="40" style="margin-right:10rpx ;"></u-icon>请先实名手机绑定再使用
				</u-button>

				<u-button type="success" :loading="enterRoomLoading" :ripple="true" @click="getRoomList" v-else>
					<u-icon name="map" size="40" style="margin-right:10rpx ;"></u-icon>点击模拟进入实验室
				</u-button>



			</view>
		</u-mask>

		<!-- 房间picker -->
		<u-select v-if="!statusInfo" v-model="showSelectRoom" mode="single-column" :list="roomList" @confirm="entryRoom"></u-select>


		<view v-else>

			<drag-button :isDock="true" :existTabBar="true" @btnClick="leaveRoom">
				<view slot="icon" class="text-xxl">
					<text class=" cuIcon-forwardfill"></text>
				</view>
			</drag-button>


			<u-sticky>
				<!-- 顶部tab栏 -->
				<cu-custom :isBack="false" bgColor="bg-shadeTop text-white" style="position: fixed;z-index: 99;">
					<block slot="content">{{statusInfo.room.rname}}</block>
				</cu-custom>
				<!-- 计时 -->
				<view class="bg-img bg-mask shadow-blur" style="background-image: url('http://mp-images.test.upcdn.net/lab1.jpg');height: 270rpx;z-index: 1;">
					<view class="flex justify-center padding-right-sm">
						<led :mode="3" :startTime="duration" style="width: 60%;padding-top: 18%;"></led>						
					</view>				
				</view>

				<!-- 状态栏 -->
				<view class="cu-list grid col-4 shadow-lg">

					<view class="cu-item">
						<view class="flex  flex-direction solid-right">
							<view class="text-df text-red text-bold">
								<u-count-to :start-val="0" :end-val="memberInfo.length" :duration="1500" :use-easing="true" ref="uCountTo1"
								 :autoplay="true" bold="true" color="#e54d42" font-size="35"></u-count-to>
							</view>
							<view class="margin-top-xs text-grey text-xs">总成员</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-blue text-bold">
								<u-count-to :start-val="0" :end-val="onlineMember.length" :duration="1500" :use-easing="true" ref="uCountTo1"
								 :autoplay="true" bold="true" color="#0081ff" font-size="35"></u-count-to>
							</view>
							<view class="margin-top-xs text-grey text-xs">在实验室</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-cyan text-bold">
								<u-count-to :start-val="0" :end-val="offlineMember.length" :duration="1500" :use-easing="true" ref="uCountTo1"
								 :autoplay="true" bold="true" color="#1cbbb4" font-size="35"></u-count-to>

							</view>
							<view class="margin-top-xs text-grey text-xs">不在实验室</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-green text-bold">
								<u-count-to :start-val="0" :end-val="roomLogInfo.length" :duration="1500" :use-easing="true" ref="uCountTo1"
								 :autoplay="true" bold="true" color="#39b54a" font-size="35"></u-count-to>
							</view>
							<view class="margin-top-xs text-grey text-xs">总日志数</view>
						</view>
					</view>

				</view>

				<!-- tab栏 -->
				<view class="shadow bg-blue">
					<u-subsection :bold="true" :list="tabsList" :current="currentTabs" @change="tabsChange" button-color="#0081ff"
					 active-color="white"></u-subsection>

				</view>
				<!-- <u-tabs class="shadow-lg" ref="tabs" :list="tabsList" :bold="true" :is-scroll="false" :current="currentTabs"
				 @change="tabsChange"></u-tabs> -->
				 				
				 <u-alert-tips type="warning" title="您目前已经在实验室超过6小时,请注意休息哦" :close-able="true" :show="isTimeOut" :show-icon="true" @close="this.isTimeOut = false"></u-alert-tips>

				 
			</u-sticky>

			<!-- :class="item.uid==that.userInfo.uid?'cu-item self':'cu-item'" -->

			<!-- 日志 -->
			<block v-if="currentTabs == 0">
				<!-- 				<view class="cu-chat bg-white padding-top-sm">
					<block v-for="(item,index) in roomLogInfo" :key="index">
						<view class="solids-bottom">
						<view class="cu-info round">{{item.ldate | duration()}}</view>
						</br>
						<view class="cu-info round"  v-if="item.during!=null">时长{{item.during | dataFormat("duration")}}</view>
						<block v-if="item.status == 0">
							<view class="cu-item self shadow">
								<view class="main">
									<view class="content  shadow bg-blue">
										<view class="cu-capsule radius">
											<view class='cu-tag bg-black lg'>
												出
											</view>
											<view class="cu-tag line-white xxl bg-white ">
												<text class="text-black">通过指纹离开</text>
											</view>
										</view>
																														
									</view>
								</view>
								<view class="cu-avatar radius shadow-blur shadow-warp" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}">
								</view>
								<view class="date" style="padding-bottom:20upx ;">{{item.ldate | dataFormat("YMD")}}{{" "}}{{item.ldate | dataFormat("Hm")}}{{" "}}星期{{item.ldate | dataFormat("E")}}</view>
								<view class="nickname-self text-bold">{{item.user.realName}}</view>
							</view>
						</block>

						<block v-else>
							<view class="cu-item shadow">
								<view class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}"></view>
								<view class="nickname text-bold">{{item.user.realName}}</view>
								<view class="main">
									<view class="content  shadow bg-green">
										<view class="cu-capsule radius">
											<view class='cu-tag bg-black lg'>
												进
											</view>
											<view class="cu-tag line-white xxl bg-white ">
												<text class="text-black">通过指纹进入</text>
											</view>
										</view>
									</view>
								</view>
								<view class="date " style="padding-bottom:20upx ;">{{item.ldate | dataFormat("YMD")}}{{" "}}{{item.ldate | dataFormat("Hm")}}{{" "}}星期{{item.ldate | dataFormat("E")}}</view>
							</view>
						</block>
						</view>
					</block>
					<u-divider half-width="250">没有更多了</u-divider>
					<u-empty text="还没有日志" mode="message" v-if="roomLogInfo.length == 0"></u-empty>
				</view> -->

				<view class="cu-timeline">
					<view class="text-bold text-xxl padding-left-sm">2020</view>
					<block v-for="(item,index) in roomLogInfo" :key="index">
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
										<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}">
											<!-- <view class="cu-tag badge lg " :class="item.status==1?'bg-green':'bg-blue'">{{item.status==1?'进':'出'}}</view> -->
										</view>
										<u-button slot="right-icon" :type="item.status==1?'success':'primary'" :ripple="true" :plain="true" size="mini">{{item.status==1?'进入':'离开'}}
										</u-button>
									</u-cell-item>

								</u-cell-group>
							</view>
						</view>
					</block>
				</view>



				<!-- 				<view class="cu-timeline " v-for="(item,index) in roomLogInfo" :key="index" v-if="currentTabs == 0">
					<view class="text-grey text-lg ">{{item.ldate | dataFormat("MD")}}({{item.ldate | duration()}})</view>
					<view class="cu-item " :class="item.status==1?'text-green':'text-blue'">
						<view class="shadow-blur content" :class="item.status==1?'bg-green':'bg-blue'">
							<view class="cu-capsule radius padd shadow-blur" v-if="item.during">
								<view class="cu-tag bg-black ">时长</view>
								<view class="cu-tag line-white">{{item.during | dataFormat("duration")}}</view>
							</view>
							<view class="cu-list menu-avatar radius">
								<view class="cu-item">
									<view class="cu-avatar radius lg" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}"></view>
									<view class="content">
										<view>
											<view class="text-bold text-xl text-black">{{item.user.realName}}</view>
											<view class="cu-tag radius sm " :class="item.status==1?'bg-green':'bg-blue'">{{item.status==1?'进':'出'}}</view>
										</view>
										<view class="text-gray text-sm flex">
											<view class="text-cut">{{item.status==1?'通过指纹进入':'通过指纹离开'}}</view>
										</view>

									</view>
									<view class="action">
										<view class="text-grey text-lg">{{item.ldate | dataFormat("Hm")}}</view>
										<view class="text-grey text-lg">星期{{item.ldate | dataFormat("E")}}</view>
									</view>
								</view>

							</view>
						</view>
					</view>
				</view> -->

			</block>




			<!-- 公告 -->
			<block v-if="currentTabs == 1">

				<view class="cu-card dynamic solids" v-for="(item,index) in adminInfo " :key="index">

					<view class="cu-item shadow">
						<view class="cu-list menu-avatar">
							<view class="cu-item">
								<view class="cu-avatar radius xxl shadow-blur" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}">
									<view class="cu-tag badge radius">管</view>
								</view>
								<view class="content flex-sub text-xs">
									<view class="text-bold text-black">{{item.user.realName}}</view>
									<view class="text-gray text-xs flex justify-between">
										{{item.ndate | dataFormat("YMDHm")}}
									</view>
								</view>
							</view>
						</view>
						<view class="padding-sm text-sm">
							{{item.notice}}
						</view>
						<view class="text-gray text-sm text-right padding-xs">
							<text class="cuIcon-attentionfill margin-lr-xs"></text>5人已读
						</view>
					</view>
				</view>
				<u-empty text="还没有公告" mode="message" v-if="adminInfo.length == 0"></u-empty>
			</block>




			<!-- 成员 -->
			<view class="padding-sm bg-white" v-if="currentTabs == 2">
				<!-- 管理员 -->
				<u-collapse>
					<u-collapse-item :title="'管理员共'+adminMember.length+'位'" open="true">
						<view class="cu-list grid col-6 no-border">
							<view class="cu-item padding-right-sm" v-for="(item,index) in adminMember" :key="index">
								<block v-if="item.isAdmin == 1">
									<view class="cu-avatar radius lg margin-sm shadow-blur" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
										<view class="cu-tag badge radius">管</view>
									</view>
									<text>{{item.user.realName}}</text>
								</block>
							</view>
						</view>
					</u-collapse-item>
				</u-collapse>

				<!-- 已在实验室人员 -->
				<u-collapse>
					<u-collapse-item :title="'在实验室人员共'+onlineMember.length+'位'" open="true">
						<view class="cu-list grid col-6 no-border">
							<view class="cu-item padding-right-sm" v-for="(item,index) in onlineMember" :key="index">
								<view class="cu-avatar radius lg margin-sm shadow-blur" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
									<view class="cu-tag badge radius" v-if="item.isAdmin == 1">管</view>
								</view>
								<text>{{item.user.realName}}</text>
							</view>
						</view>
					</u-collapse-item>
				</u-collapse>

				<!-- 不在实验室人员 -->
				<u-collapse>
					<u-collapse-item :title="'不在实验室人员共'+offlineMember.length+'位'" open="true">
						<view class="cu-list grid col-6 no-border">
							<!-- 非管理员 -->
							<view class="cu-item padding-right-sm" v-for="(item,index) in offlineMember" :key="index">
								<view class="cu-avatar radius lg margin-sm grayscale shadow-blur" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
									<view class="cu-tag badge radius" v-if="item.isAdmin == 1">管</view>
								</view>
								<text class="text-bold text-black">{{item.user.realName}}</text>
							</view>
						</view>
					</u-collapse-item>
				</u-collapse>
				<u-divider>没有更多了</u-divider>
			</view>


			<!-- 文件 -->
			<block v-else-if="currentTabs == 3">
				<view class="cu-card dynamic shadow solids">
					<u-cell-group class="margin-top shadow-lg">

						<u-cell-item :arrow="false" value="05-15" @click="showToast('该功能开发中,敬请期待','primary','bottom')">
							<view slot="title" class="text-black text-bold text-sm padding">{{statusInfo.room.rname}}注意事项.word</br><text
								 class="text-grey text-xs">来自{{userInfo.realName}}</text></text></view>
							<view slot="icon" class="cu-avatar radius shadow-blur" style="background-image: url('http://mp-images.test.upcdn.net/word2.png')">
								<!-- <view class="cu-tag badge lg">{{index+1}}</view> -->
							</view>
							<!-- <view slot="right-icon" class="text-black text-bold text-lg">{{item.allDuration | dataFormat("duration")}}</view> -->
						</u-cell-item>

					</u-cell-group>
				</view>
			</block>


			<!-- 概览 -->
			<block v-else-if="currentTabs == 4">
				<view class="cu-list card-menu shadow margin-top">
					<u-cell-group>
						<u-cell-item :arrow="false" :center="true" title="实验室rid" :value="statusInfo.rid">
							<!-- <u-icon slot="icon" size="32" color="yellow" name="star"></u-icon> -->
							<view slot="icon" class="cuIcon-title padding-right-sm text-green"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="实验室名称" :value="statusInfo.room.rname">
							<view slot="icon" class="cuIcon-home padding-right-sm text-blue"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="地址" :value="statusInfo.room.address">
							<view slot="icon" class="cuIcon-location padding-right-sm text-red"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="管理员" @click="showAdmin">
							<view slot="icon" class="cuIcon-peoplelist padding-right-sm text-orange"></view>
							<view class="action" slot="right-icon" v-if="adminMember.length > 0">
								<view class="cu-avatar-group">
									<block v-for="(item,index) in adminMember" :key="index">
										<view class="cu-avatar round sm" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]" v-if="index<4"></view>
									</block>
								</view>
								<text class="text-grey text-sm">等{{adminMember.length}}人<text class="cuIcon-right padding-left-xs text-grey" /></text>
							</view>

							<view class="action" slot="right-icon" v-else>
								<text class="text-grey text-sm">无管理员<text class="cuIcon-right padding-left-xs text-grey" /></text>
							</view>

						</u-cell-item>

						<u-cell-item :arrow="false" :center="true" title="状态">
							<view slot="icon" class="cuIcon-attention padding-right-sm text-cyan"></view>
							<u-button slot="right-icon" :type="statusInfo.room.del == 1?'success':'error'" :ripple="true" :plain="true" size="mini">{{statusInfo.room.del == 1?'已开放':'未开放'}}</u-button>
							<!-- <view slot="right-icon" class="cu-tag radius" :class="statusInfo.room.del == 1?'bg-green':'bg-red'" >{{statusInfo.room.del == 1?'已开放':'未开放'}}</view> -->
						</u-cell-item>
					</u-cell-group>
				</view>
			</block>







		</view>










	</view>
</template>

<script>
	import led from '../../components/mehaotian-numled/mehaotian-numled.vue';
	import uniFab from '@/components/uni-fab/uni-fab.vue';
	import dragButton from "@/components/drag-button/drag-button.vue";
	import moment from 'moment'
	export default {
		components: {
			led,
			dragButton,
			uniFab
		},
		data() {
			return {

				isTimeOut:false,
				CustomBar: this.CustomBar,
				loadProgress: 0,
				scrollTop: 1,
				modalName: "",
				// 进入房间
				showSelectRoom: false,
				enterRoomLoading: false,
				roomList: [],
				// 房间状态等信息				
				roomLogInfo: "",
				adminInfo: "",
				statusInfo: null,
				memberInfo: "",
				onlineMember: [],
				offlineMember: [],
				adminMember: [],
				// 用户信息
				wxuserInfo: "",
				userInfo: null,

				// tab选择栏
				currentTabs: 0,
				// 计时
				duration: [0, 0, ':', 0, 0, ':', 0, 0],
				tabsList: [{
					name: '日志'
				}, {
					name: '公告'
				}, {
					name: '成员'
				}, {
					name: '文件'
				}, {
					name: '概览'
				}],
				// 成员详细索引

			}
		},

		onLoad() {


		},
		onReady() {

		},
		onShow() {
			var that = this

			uni.setEnableDebug({
				enableDebug: true
			})
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")
			/* that.loadProgress_onShow() */
			that.getStatus()

		},
		methods: {
			showAdmin() {
				this.currentTabs = 2
			},
			toRealName() {
				uni.switchTab({
					url: "../profile/profile"
				})
			},
			loadProgress_onShow() {
				if (this.loadProgress < 100 && !this.statusInfo) {
					setTimeout(() => {
						this.loadProgress_onShow();
					}, 100)
				} else {
					this.loadProgress = 0;
				}
			},
			// 获取房间
			getRoomList() {
				var that = this;
				that.enterRoomLoading = true
				that.roomList = []
				uni.request({
					url: "http://47.100.59.153:8885/MP/public/getRoomList",
					success(res) {
						console.log(res)
						that.roomList = res.data.roomList.reverse()
						/* for (let i = res.data.roomList.length - 1; i > -1; i--) {
							that.roomList.push(res.data.roomList[i])
						} */

						for (let i = that.roomList.length - 1; i >= 0; i--) {
							that.roomList[i].value = that.roomList[i].rid
							that.roomList[i].label = that.roomList[i].rname
							if (that.roomList[i].del == 0) {
								that.roomList[i].label = that.roomList[i].label + "(已禁用)"
							}
						}
						that.enterRoomLoading = false
						that.showSelectRoom = true
					}
				})
			},
			subscribeMsg: function(e) {
				wx.requestSubscribeMessage({
					tmplIds: [
						'X9OJzmxUJAI_22RUvEbIXkHZEZ1CAkhPvLNA4OdgTz4',
					],
					success(res) {
						console.log(res)
					},
					fail(err) {
						console.log(err);
					}
				})
			},
			// 发送服务通知
			sendMsg(e) {
				var that = this
				console.log("e=" + e.date)
				wx.cloud.callFunction({
					name: 'sendMsg',
					data: {
						"info": e
					},
					success(res) {
						console.log(res);
						that.showToast("模拟发送服务通知成功", "primary", "bottom")

					},
					fail(err) {
						console.log(err);
						that.showToast("模拟发送服务通知失败", "warn", "bottom")
					}
				})
			},

			// 进入房间
			entryRoom(e) {
				var that = this
				// var index = e.detail.value
				console.log(e)
				console.log(e[0].value)
				var rid = e[0].value
				for (let i = that.roomList.length - 1; i > -1; i--) {
					if (that.roomList[i].rid == rid)
						var room = that.roomList[i]
				}
				that.roomList = []
				if (room.del == 0) {
					that.showToast_mask("实验室"+room.rname+"已关闭", "error", "bottom")
					return false
				} else {
					uni.request({
						url: "http://47.100.59.153:8885/MP/home/entryRoom",
						data: {
							uid: that.userInfo.uid,
							rid: rid
						},
						success(res) {
							console.log(res)
							that.getStatus()

							that.enterRoomLoading = false
							that.showSelectRoom = false
							that.showToast("模拟进入实验室" + room.rname + "成功", "success", "bottom")

							var msg = {}
							msg.user = that.userInfo.realName
							msg.date = moment().locale('zh-cn').format('YYYY-MM-DD HH:mm:ss')
							msg.rname = room.rname
							msg.status = "进入"
							msg.address = room.address



							that.subscribeMsg()
							that.sendMsg(msg)
						}
					})
				}



			},
			// 离开房间
			leaveRoom() {
				var that = this
				uni.showModal({
					title: "确定要模拟退出实验室吗",
					success: function(res) {
						if (res.confirm) {
							uni.request({
								url: "http://47.100.59.153:8885/MP/home/leaveRoom",
								data: {
									uid: that.userInfo.uid,
									rid: that.statusInfo.rid
								},
								success(res) {
									that.duration = [0, 0, ':', 0, 0, ':', 0, 0]

									var msg = {}
									msg.user = that.userInfo.realName
									msg.date = moment().locale('zh-cn').format('YYYY-MM-DD HH:mm:ss')
									msg.rname = that.statusInfo.room.rname
									msg.status = "退出"
									msg.address = that.statusInfo.room.address
									that.subscribeMsg()
									that.sendMsg(msg)

									that.getStatus()
									that.showToast("模拟退出实验室成功", "success", "bottom")
								}
							})
						}
					}
				})

			},
			start() {
				var that = this
				that.$refs.uCountTo.start();
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
			// toast提示mask
			showToast_mask(title, type, position) {
				this.$refs.uToastMask.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			},
			// 打开modal
			showModal(e) {
				console.log("???")
				this.modalName = e.currentTarget.dataset.modal
			},
			hideModal(e) {
				this.modalName = null
			},
			// tabs栏切换
			tabsChange(index) {

				this.currentTabs = index;
			},
			// 成员索引
			scroll_member(e) {
				this.scrollTop_member = e.detail.scrollTop
			},
			// 获取状态
			getStatus() {
				uni.showLoading({
					title: "获取当前状态"
				})
				var that = this
				if (that.userInfo != null) {
					uni.request({
						url: "http://47.100.59.153:8885/MP/home/getStatus",
						data: {
							uid: that.userInfo.uid,
						},
						success(res) {
							console.log(res)
							that.statusInfo = res.data.statusInfo
							if (res.data.code == 200) {
								console.log("您还未进入教室")
								that.roomLogInfo = null
								that.adminInfo = null
								that.memberInfo = null
							} else if (res.data.code == 201) {
								that.roomLogInfo = res.data.roomLogInfo
								that.adminInfo = res.data.adminInfo
								that.memberInfo = res.data.memberInfo

								// 过滤掉已删除的
								var adminInfo2 = []
								for (let item of that.adminInfo) {
									if (item.del == 1) {
										adminInfo2.push(item)
									}
								}
								that.adminInfo = adminInfo2

								// 初始化所在时长
								var now = moment()
								var duration = now.diff(moment(that.statusInfo.ldate))
								console.log("时长" + duration)
								if (duration < 0) {
									that.duration = [0, 0, ':', 0, 0, ':', 0, 0]
								} else {
									var h = Math.floor(duration / 1000 / 60 / 60);
									console.log("h" + h)
									that.duration[0] = Math.floor(h / 10)
									that.duration[1] = Math.floor(h % 10)
									var m = Math.floor(duration / 1000 / 60 % 60);
									console.log("m" + m)
									that.duration[3] = Math.floor(m / 10)
									that.duration[4] = Math.floor(m % 10)
									var s = Math.floor(duration / 1000 % 60);
									console.log("s" + s)
									that.duration[6] = Math.floor(s / 10)
									that.duration[7] = Math.floor(s % 10)
								}
								
								console.log("在实验室时间=="+that.duration)


								// 初始化在线和不在线人
								that.onlineMember = []
								that.offlineMember = []
								that.adminMember = []
								for (let i = 0; i < that.memberInfo.length; i++) {
									console.log("xxx" + that.memberInfo[i])
									if (that.memberInfo[i].isAdmin == 1) {
										that.adminMember.push(that.memberInfo[i])
									}

									if (that.memberInfo[i].status == 1) {
										that.onlineMember.push(that.memberInfo[i])
									} else if (that.memberInfo[i].status == 0) {
										that.offlineMember.push(that.memberInfo[i])
									}
								}
								
							
								that.showToast("当前在" + that.roomLogInfo[0].room.rname, "success", "bottom")
								
								if(h > 5){
									that.isTimeOut = true
									setTimeout(function () {
									that.showToast("您目前已经在实验室超过6小时,请注意休息哦", "warning","bottom")									
									}, 2500);									
								}else{
									that.isTimeOut = false
								}
								
							}


						}
					})
				}
				uni.hideLoading()
			}




		}
	}
</script>

<style>
	.indexes {
		position: relative;
	}

	.indexBar {
		position: fixed;
		right: 0px;
		bottom: 0px;
		padding: 20upx 20upx 20upx 60upx;
		display: flex;
		align-items: center;
	}

	.indexBar .indexBar-box {
		width: 40upx;
		height: auto;
		background: #fff;
		display: flex;
		flex-direction: column;
		box-shadow: 0 0 20upx rgba(0, 0, 0, 0.1);
		border-radius: 10upx;
	}

	.indexBar-item {
		flex: 1;
		width: 40upx;
		height: 40upx;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 24upx;
		color: #888;
	}

	movable-view.indexBar-item {
		width: 40upx;
		height: 40upx;
		z-index: 9;
		position: relative;
	}

	movable-view.indexBar-item::before {
		content: "";
		display: block;
		position: absolute;
		left: 0;
		top: 10upx;
		height: 20upx;
		width: 4upx;
		background-color: #f37b1d;
	}

	.indexToast {
		position: fixed;
		top: 0;
		right: 80upx;
		bottom: 0;
		background: rgba(0, 0, 0, 0.5);
		width: 100upx;
		height: 100upx;
		border-radius: 10upx;
		margin: auto;
		color: #fff;
		line-height: 100upx;
		text-align: center;
		font-size: 48upx;
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
		padding-bottom: 30upx;
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
