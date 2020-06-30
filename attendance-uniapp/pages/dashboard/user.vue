<template>
	<view>
		<u-toast ref="uToast" />


		<!-- 抽屉主界面 -->
		<scroll-view scroll-y class="DrawerPage" :class="modalName=='showUserDetail'?'show':''">
			<u-sticky>

				<u-navbar title="用户列表" :background="{ background: '#00152a' }" is-fixed="true" title-size="40" :is-back="true"
				 title-color="#ffffff" back-text="返回" :back-text-style="{color: '#fff'}" back-icon-color="white">
				</u-navbar>


				<view class="cu-list grid col-4 ">
					<view class="cu-item">
						<view class="text-xl text-green text-bold">
							<u-count-to :start-val="0" :end-val="userList.length " :duration="1500" :use-easing="true" ref="uCountTo1"
							 :autoplay="true" bold="true" color="#39b54a"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">总数</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-blue text-bold">
							<u-count-to :start-val="0" :end-val="1" :duration="1500" :use-easing="true" ref="uCountTo1" :autoplay="true"
							 bold="true" color="#0081ff"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">今日新增</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-blue text-bold">
							<u-count-to :start-val="0" :end-val="realUserList.length" :duration="1500" :use-easing="true" ref="uCountTo1"
							 :autoplay="true" bold="true" color="#f37b1d"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">已实名</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-blue text-bold">
							<u-count-to :start-val="0" :end-val="unRealUserList.length" :duration="1500" :use-easing="true" ref="uCountTo1"
							 :autoplay="true" bold="true" color="#red"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">未实名</view>
					</view>

				</view>


				<u-subsection :list="subsectionList" :current="currentTab" @change="sectionChange" button-color="#0081ff"
				 active-color="white"></u-subsection>
			</u-sticky>

			<!-- 已实名索引 -->
			<u-index-list :scrollTop="scrollTop" v-if="currentTab == 0" :index-list="indexList">
				<view v-for="(item, index) in indexList" :key="index">
					<u-index-anchor :index="item" class="padding-top " />
					<u-cell-group class="margin-top shadow-lg">

						<u-cell-item :arrow="false" v-for="(item2,index2) in realUserList" :key="index2" v-if="item2.index == item"
						 @click="showUserDetail(item2.uid)">
							<view slot="title" class="text-black text-bold text-lg padding-xs">{{item2.user.realName}}<text class="text-grey">
									({{item2.nickName}})</text></view>
							<view slot="icon" class="cu-avatar radius " :style="{backgroundImage:'url('+item2.avatarUrl+')'}">
								<view class="cu-tag badge " v-if="item2.user.level == 1">超管</view>
							</view>
							<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="showUserDetail(item2.uid)">查看详情</u-button>
						</u-cell-item>

					</u-cell-group>
				</view>
			</u-index-list>

			<!-- 未实名 -->
			<u-cell-group class="margin-top shadow-lg">
				<u-cell-item :arrow="false" v-for="(item,index) in unRealUserList" :key="index" v-if="currentTab == 1">
					<view slot="title" class="text-black text-bold text-lg padding-xs">未实名<text class="text-grey">
							（{{item.nickName}})</text></view>
					<view slot="icon" class="cu-avatar radius " :style="{backgroundImage:'url('+item.avatarUrl+')'}">
			
					</view>
				</u-cell-item>
			
			</u-cell-group>
			
			
			
<!-- 			<u-index-list :scrollTop="scrollTop" v-else :index-list="indexList">
				<view v-for="(item, index) in indexList" :key="index">
					<u-index-anchor :index="item" class="padding-top " />
					<u-cell-group class="margin-top shadow-lg">
						<u-cell-item :arrow="false" v-for="(item2,index2) in unRealUserList" :key="index2" v-if="item2.index == item&&currentTab == 1">
							<view slot="title" class="text-black text-bold text-lg padding-xs">{{item2.user.nickName}}<text class="text-grey">
									(未实名)</text></view>
							<view slot="icon" class="cu-avatar radius " :style="{backgroundImage:'url('+item2.avatarUrl+')'}">

							</view>
						</u-cell-item>

					</u-cell-group>
				</view>
			</u-index-list> -->


		</scroll-view>

		<!-- 从抽屉返回主页面 -->
		<view class="DrawerClose" :class="modalName=='showUserDetail'?'show':''" @tap="hideModal">
			<text class="cuIcon-pullright"></text>
		</view>





		<u-calendar v-model="isCale" mode="range" safeAreaInsetBottom="true" @change="changeCale" :closeable="false">
			<view slot="tooltip" style="text-align: center;">
				<u-button type="primary" size="default" :ripple="true" @click="changeCale2">查看所有</u-button>
			</view>
		</u-calendar>


		<scroll-view scroll-y class="DrawerWindow" :class="modalName=='showUserDetail'?'show':''" :scroll-top="scrollTop"
		 @scroll="scroll">


			<view style="position: fixed;top:0;width: 100%;z-index: 10;" class="padding-top-lg">
				<view class="cu-list grid col-4">
					<view class="cu-item">
						<view class="text-xl text-green text-bold">
							<u-count-to :start-val="0" :end-val="userLog_len" :duration="1500" :use-easing="true" :autoplay="true" bold="true"
							 color="#39b54a" font-size="35"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">日志数</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-black text-bold">
							<u-count-to :start-val="0" :end-val="Math.floor(allDuration/1000/3600) " :duration="1500" :use-easing="true"
							 :autoplay="true" bold="true" color="#0081ff" font-size="35"></u-count-to>h
							<u-count-to :start-val="0" :end-val="Math.floor(allDuration/1000/60%60) " :duration="1500" :use-easing="false"
							 :autoplay="true" bold="true" color="#0081ff" font-size="35"></u-count-to>m
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">活跃度</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-blue text-bold">
							<u-count-to :start-val="0" :end-val="userRoom_len" :duration="1500" :use-easing="true" :autoplay="true" bold="true"
							 color="#1cbbb4" font-size="35"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">去过的实验室</view>
					</view>
					<view class="cu-item">
						<view class="text-xl text-blue text-bold">
							<u-count-to :start-val="0" :end-val="userAdminRoom_len" :duration="1500" :use-easing="true" :autoplay="true"
							 bold="true" color="#f37b1d" font-size="35"></u-count-to>
						</view>
						<view class=" text-grey text-xs " style="padding-top: 15rpx;">管理的实验室</view>
					</view>

				</view>

				<view class="bg-blue shadow-blur">
					<u-subsection :list="userDetailTabs" :current="currentDetailTab" @change="userDetailTabsChange" button-color="#0081ff"
					 active-color="white"></u-subsection>

					<u-cell-group v-if="currentDetailTab > 0">
						<u-cell-item :title="'从'+startDate+'到'+endDate" :label="'时长'+Math.floor(allDuration2/1000/3600)+'时'+Math.floor(allDuration2/1000/60%60)+'分,共'+userLog.length+'条日志'"
						 :arrow="false" @tap="showCale" v-if="startDate!=null&&endDate!=null&&currentDetailTab == 1">
							<view slot="icon" class="cuIcon-calendar padding-right-sm padding-bottom-lg text-blue"></view>
							<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="showCale">筛选</u-button>
						</u-cell-item>

					</u-cell-group>

				</view>
			</view>

			<view style="margin-top: 210upx;">
				<!-- 基本信息 -->
				<block v-if="currentDetailTab == 0">
					<view class="cu-list card-menu shadow margin-top">
						<u-cell-group>
							<u-cell-item :arrow="false">
								<view slot="title" class="text-black text-bold text-lg padding">{{userDetail.realName}}<text class="text-grey">
										({{userDetail.wxuser.nickName}})</text></view>
								<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+userDetail.wxuser.avatarUrl+')'}">
									<view class="cu-tag badge" :class="wxuserInfo.gender==1?'cuIcon-male bg-blue':'cuIcon-male bg-blue'">
									</view>
								</view>
								<u-button slot="right-icon" type="success" :ripple="true" :plain="true" size="mini">已实名</u-button>
							</u-cell-item>

							<u-cell-item :arrow="false" :center="true" title="uid" :value="userDetail.uid">
								<view slot="icon" class="cuIcon-title padding-right-sm text-green"></view>
							</u-cell-item>
							<!-- 						<u-cell-item :arrow="false" :center="true" title="真实姓名" :value="userDetail.realName">
							<view slot="icon" class="cuIcon-profile padding-right-sm text-blue"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="微信昵称" :value="userDetail.wxuser.nickName">
							<view slot="icon" class="cuIcon-profile padding-right-sm text-pink"></view>
						</u-cell-item> -->
							<u-cell-item :arrow="false" :center="true" title="手机"  @click="callPhone(userDetail.phone)">
								<view slot="icon" class="cuIcon-phone padding-right-sm text-red"></view>
								<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="callPhone(userDetail.phone)">拨打{{userDetail.phone}}</u-button>
							</u-cell-item>
							<u-cell-item :arrow="false" :center="true" title="注册时间" :value="regDate">
								<view slot="icon" class="cuIcon-calendar padding-right-sm text-cyan"></view>
							</u-cell-item>
							<u-cell-item :arrow="false" :center="true" title="上次登录" :value="lastLoginDate">
								<view slot="icon" class="cuIcon-calendar padding-right-sm text-blue"></view>
							</u-cell-item>
							<u-cell-item :arrow="false" :center="true" title="权限" value="超级管理员" v-if="userDetail.level == 1">
								<view slot="icon" class="cuIcon-flashbuyfill padding-right-sm text-orange"></view>
							</u-cell-item>
							<u-cell-item :arrow="false" :center="true" title="权限" value="普通用户" v-else>
								<view slot="icon" class="cuIcon-flashbuyfill padding-right-sm text-orange"></view>
							</u-cell-item>
						</u-cell-group>
					</view>


				</block>

				<!-- 日志 -->
				<block v-else-if="currentDetailTab == 1">
					<view style="padding-top: 110upx;">
						<u-empty text="还没有日志" mode="message" v-if="userLog.length == 0"></u-empty>

						<block v-else-if="userLog.length > 0">
							<!-- 日历筛选 -->
							<drag-button :isDock="true" :existTabBar="true" @btnClick="showCale" v-if="modalName=='showUserDetail'&&currentDetailTab == 1">
								<view slot="icon" class="text-xxl">
									<text class=" cuIcon-calendar "></text>
								</view>
							</drag-button>

							<view class="cu-timeline">
								<view class="text-bold text-xxl padding-left-sm">2020</view>
								<block v-for="(item,index) in userLog" :key="index">
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
													<view slot="title" class="text-black text-bold text-sm padding-left-sm">通过指纹{{item.status==1?'进入':'离开'}}</br>

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
						</block>



					</view>

				</block>


				<!-- 去过的实验室 -->
				<block v-else-if="currentDetailTab == 2">
					<u-empty text="还没有去过的实验室" mode="message" v-if="userRoom.length == 0"></u-empty>
					<view class="cu-card " v-else-if="userRoom.length > 0">
						<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
						 v-for="(item,index) in userRoom" style="height: 180upx;" :key="index" @click="toRoomDetail" :data-rid="item.rid"
						 :data-rname="item.rname" :data-address="item.address" :data-del="item.del">
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


				<!-- 管理的实验室列表 -->
				<block v-else-if="currentDetailTab == 3">
					<u-empty text="还没有管理的实验室" mode="message" v-if="userAdminRoom.length == 0"></u-empty>
					<view class="cu-card bg-white" v-else-if="userAdminRoom.length > 0">
						<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
						 style="height: 180upx;" v-for="(item,index) in userAdminRoom" :key="index" @click="toRoomDetail" :data-rid="item.rid"
						 :data-rname="item.room.rname" :data-address="item.room.address" :data-del="item.room.del">
							<navigator>
								<view class="flex solid-bottom justify-between">
									<view class="padding-left-xl padding-top-sm text-white">
										<view class=" text-xxl text-bold">
											{{item.room.rname}}
										</view>
										<view class="padding-top-xs text-lg">
											<u-button type="primary" :ripple="true" size="mini"><text class='cuIcon-location'></text>{{item.room.address}}</u-button>
										</view>
									</view>
									<u-tag text="已开放" type="success" mode="dark" v-if="item.room.del == 1" />
									<u-tag text="已关闭" type="error" mode="dark" v-else />
								</view>
							</navigator>
						</view>
					</view>
				</block>

			</view>


		</scroll-view>






	</view>
</template>

<script>
	import {
		initial
	} from '../../libs/chineseConversion.js'
	import moment from 'moment'
	export default {

		data() {
			return {
				// userDetail
				userDetail: null,
				userLog: [],
				userRoom: [],
				userAdminRoom: [],

				modalName: null,

				userList: null,
				realUserList: null,
				unRealUserList: null,
				scrollTop: 0,
				old: {
					scrollTop: 0
				},
				indexList_temp: [{
					value: "A",
					index: 0
				}, {
					value: "B",
					index: 0
				}, {
					value: "C",
					index: 0
				}, {
					value: "D",
					index: 0
				}, {
					value: "E",
					index: 0
				}, {
					value: "F",
					index: 0
				}, {
					value: "G",
					index: 0
				}, {
					value: "H",
					index: 0
				}, {
					value: "I",
					index: 0
				}, {
					value: "J",
					index: 0
				}, {
					value: "K",
					index: 0
				}, {
					value: "L",
					index: 0
				}, {
					value: "M",
					index: 0
				}, {
					value: "N",
					index: 0
				}, {
					value: "O",
					index: 0
				}, {
					value: "P",
					index: 0
				}, {
					value: "Q",
					index: 0
				}, {
					value: "R",
					index: 0
				}, {
					value: "S",
					index: 0
				}, {
					value: "T",
					index: 0
				}, {
					value: "U",
					index: 0
				}, {
					value: "V",
					index: 0
				}, {
					value: "W",
					index: 0
				}, {
					value: "X",
					index: 0
				}, {
					value: "Y",
					index: 0
				}, {
					value: "Z",
					index: 0
				}],
				indexList: [],
				currentTab: 0,
				subsectionList: [{
						name: '已实名'
					},
					{
						name: '未实名'
					}

				],
				currentDetailTab: 0,
				userDetailTabs: [{
						name: '基本信息'
					},
					{
						name: '日志'
					},
					{
						name: '去过'
					},
					{
						name: '管理'
					}

				],
				isCale: false,
				startDate: null,
				endDate: null,
				allDuration: 0,
				allDuration2: 0,
				userLog_len: 0,
				userRoom_len: 0,
				userAdminRoom_len: 0,
				regDate: null,
				lastLoginDate:null,
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onShow() {
			var that = this
			that.getAllUser()


		},

		methods: {
			// toast提示
			showToast(title, type, position) {
				this.$refs.uToast.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			},
			scroll: function(e) {
				this.old.scrollTop = e.detail.scrollTop
			},
			callPhone(phone){
				uni.makePhoneCall({
					phoneNumber:phone
				})
			},

			// 打开日期筛选
			showCale() {
				this.isCale = true
			},
			// 去实验室详情
			toRoomDetail(e) {
				var that = this
				var rid = e.currentTarget.dataset.rid
				var rname = e.currentTarget.dataset.rname
				var address = e.currentTarget.dataset.address
				var del = e.currentTarget.dataset.del
				uni.navigateTo({
					url: "room?rid=" + rid + '&rname=' + rname + '&address=' + address + '&del=' + del
				})
			},

			changeCale2() {
				var that = this
				that.isCale = false
				var e = {}
				e.startDate = null
				e.endDate = null
				that.changeCale(e)
			},
			
			// 抽屉界面回到顶部
			toTop(){
				var that = this
				that.scrollTop = that.old.scrollTop
				that.$nextTick(function() {
					that.scrollTop = 0
				});
			},

			// 日志筛选
			changeCale(e) {
				var that = this
				console.log(e)
				var startDate = e.startDate
				var endDate = e.endDate

				if (startDate == null && endDate == null) {
					that.userLog = that.userLog2
					that.allDuration2 = that.allDuration
					that.startDate = moment(that.userLog2[that.userLog2.length - 1].ldate).format('YYYY-MM-DD')
					that.endDate = moment(that.userLog2[0].ldate).format('YYYY-MM-DD')
				} else {
					var allDuration2 = 0
					console.log("选择日期模式")
					var userLog_2 = []
					for (let i = 0; i < that.userLog.length; i++) {
						let ldate = moment(that.userLog[i].ldate).format('YYYY-MM-DD')
						if (moment(ldate).isBefore(startDate) == false && moment(ldate).isAfter(endDate) == false) {
							console.log("符合条件" + that.userLog[i])
							userLog_2.push(that.userLog[i])
							if (that.userLog[i].during != null) {
								allDuration2 = allDuration2 + that.userLog[i].during
							}
						}
					}
					that.userLog = userLog_2
					that.allDuration2 = allDuration2
					that.startDate = startDate
					that.endDate = endDate
				}

				that.toTop()
				that.showToast("获取从" + that.startDate + "到" + that.endDate + "的日志成功", "success", "bottom")

			},

			// 去查看用户详情
			showUserDetail(uid) {
				var that = this
				var uid = uid
				that.modalName = "showUserDetail"
				uni.showLoading({
					title: "获取用户信息中"
				})
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/getUserDetail",
					data: {
						uid: uid
					},
					success(res) {
						console.log(res)
						that.userDetail = res.data.userDetail
						that.userLog = res.data.userLog
						that.userLog2 = res.data.userLog
						that.userRoom = res.data.userRoom
						that.userAdminRoom = res.data.userAdminRoom

						that.userLog_len = that.userLog.length
						that.userRoom_len = that.userRoom.length
						that.userAdminRoom_len = that.userAdminRoom.length

						that.allDuration = 0
						if(res.data.userAllDuration.length > 0){
							that.allDuration = res.data.userAllDuration[0].allDuration
						}						
						that.allDuration2 = that.allDuration

						if(that.userLog.length > 0){
							that.startDate = moment(that.userLog[that.userLog.length - 1].ldate).format('YYYY-MM-DD')
							that.endDate = moment(that.userLog[0].ldate).format('YYYY-MM-DD')
						}else{
							that.startDate = 0
							that.endDate = 0
						}						
						that.regDate = moment(that.userDetail.wxuser.regDate).format('YYYY-MM-DD HH:mm:ss')
						that.lastLoginDate = moment(that.userDetail.wxuser.lastLoginDate).format('YYYY-MM-DD HH:mm:ss')
											
						that.toTop()
						that.showToast("获取" + that.userDetail.realName + "的信息成功", "success", "bottom")

					}
				})
				uni.hideLoading()
			},
			userDetailTabsChange(index) {
				var that = this
				that.currentDetailTab = index


			},
			// modal隐藏唤醒
			showUserDetailModal(index) {
				console.log(index)
				var that = this
				that.userDetail = null
				for (let item of that.realUserList) {
					if (item.uid == index) {
						that.userDetail = item
						that.userDetail.regDate = moment(that.userDetail.regDate).format('YYYY-MM-DD HH:mm:ss')
					}
				}
				this.modalName = "showUserDetail"
			},
			hideModal(e) {
				this.modalName = null
			},
			showDetailModal(e) {
				var that = this
				console.log(e)
				that.showDetail = true
			},
			// 监听
			sectionChange(index) {
				this.currentTab = index;
			},
			getAllUser() {
				uni.showLoading({
					title: '正在加载所有用户'
				})
				var that = this
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/getAllUser",
					data: {},
					success(res) {
						console.log(res)
						that.userList = res.data.userList
						that.realUserList = []
						that.unRealUserList = []
						for (let item of that.userList) {
							if(item.user!=null){
								item.index = initial(item.user.realName)
								for (let item2 of that.indexList_temp) {
									if (item2.value == item.index) {
										console.log("符合条件")
										item2.index = 1
									}
								}
								that.realUserList.push(item)
							}else{
								that.unRealUserList.push(item)
							}
							
							
						}
						that.indexList = []
						for (let item of that.indexList_temp) {
							if (item.index == 1) {
								that.indexList.push(item.value)
							}
						}

						uni.hideLoading()
						that.showToast("获取用户列表成功", "success", "bottom")
					}
				})
			}
		}
	}
</script>

<style>
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
