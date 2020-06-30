<template>
	<view class="bg-white">

		<u-toast ref="uToast" />
		<!-- 悬浮按钮 -->
		<!-- 返回顶部 -->
		<u-back-top :scroll-top="scrollTop" mode="square" top="0" bottom="20"></u-back-top>





		<u-sticky>
			<u-navbar title="控制台" :background="{ background: '#00152a' }" is-fixed="true" title-size="40" :is-back="false"
			 title-color="#ffffff">
			</u-navbar>
			<!-- 实验室总览 -->
			<view class="bg-white">
				<u-collapse style="background-color: white;z-index: 9999;">
					<u-collapse-item title="实验室总览" :open="collapse" >
						<!-- 状态栏 -->
						<view class="cu-list grid col-4 ">
							<view class="cu-item">
								<view class="text-xl text-green text-bold">
									<u-count-to :start-val="0" :end-val="roomList.length " :duration="1500" :use-easing="true" ref="uCountTo1"
									 :autoplay="true" bold="true" color="#39b54a" font-size="40"></u-count-to>
								</view>
								<view class=" text-grey text-xs " style="padding-top: 15rpx;">总数</view>
							</view>
							<view class="cu-item">
								<view class="text-xl text-blue text-bold">
									+<u-count-to :start-val="0" :end-val="1" :duration="1500" :use-easing="true" ref="uCountTo1" :autoplay="true"
									 bold="true" color="#0081ff" font-size="40"></u-count-to>
								</view>
								<view class=" text-grey text-xs " style="padding-top: 15rpx;">今日新增</view>
							</view>
							<view class="cu-item">
								<view class="text-xl text-orange text-bold">
									<u-count-to :start-val="0" :end-val="openRoomList.length " :duration="1500" :use-easing="true" ref="uCountTo1"
									 :autoplay="true" bold="true" color="#f37b1d" font-size="40"></u-count-to>
								</view>
								<view class=" text-grey text-xs " style="padding-top: 15rpx;">已开放</view>
							</view>
							<view class="cu-item">
								<view class="text-xl text-black text-bold">
									<u-count-to :start-val="0" :end-val="closeRoomList.length " :duration="1500" :use-easing="true" ref="uCountTo1"
									 :autoplay="true" bold="true" color="red" font-size="40"></u-count-to>
								</view>
								<view class=" text-grey text-xs " style="padding-top: 15rpx;">已关闭</view>
							</view>
						</view>
					</u-collapse-item>
				</u-collapse>
			</view>


			<!-- 			<u-cell-group>
				<u-cell-item title="实验室总览" :arrow="true"  arrow-direction="down" >
					<view slot="icon" class="cuIcon-discover padding-right-sm  text-red"></view>
					</u-cell-item>
			</u-cell-group> -->


			<u-subsection :bold="true" :list="tabsList" :current="currentTabs" @change="tabsChange" button-color="#0081ff"
			 active-color="white"></u-subsection>


			<!-- 实验室二级菜单 -->
			<u-tabs ref="tabs" :list="roomTabsList" :bold="true" :is-scroll="false" :current="currentLabTabs" @change="labTabsChange"
			 height="70" font-size="25" v-if="currentTabs==0"></u-tabs>

			<!-- 			 <u-subsection :bold="true" :list="roomTabsList" :current="currentLabTabs" @change="labTabsChange" mode="subsection" v-if="currentTabs==0"></u-subsection> -->

			<view class="shadow bg-blue">
				<!-- 日志信息 -->
				<u-cell-group v-if="currentTabs == 2 && userInfo.level == 1">
					<u-cell-item :title="'从'+startDate+'到'+endDate" :label="'共'+logList.length+'条日志'" :arrow="false" arrow-direction="down"
					 @tap="showCale">
						<view slot="icon" class="cuIcon-calendar padding-right-sm text-blue"></view>
						<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="showCale">日期筛选</u-button>
					</u-cell-item>
				</u-cell-group>



				<!-- 统计实验室数量 -->
				<u-cell-group v-if="currentTabs == 0">
					<u-cell-item :title="'共有'+roomList.length+'间实验室'" :arrow="false" v-if="currentLabTabs == 0" @click="readyAddRoom">
						<view slot="icon" class="cuIcon-discover padding-right-sm  text-blue"></view>
						<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="readyAddRoom" v-if="userInfo.level == 1">添加实验室</u-button>
					</u-cell-item>
					<u-cell-item :title="'共有'+openRoomList.length+'间实验室已开放'" :arrow="false" v-else-if="currentLabTabs == 1">
						<view slot="icon" class="cuIcon-discover padding-right-sm  text-blue"></view>
						<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="readyAddRoom" v-if="userInfo.level == 1">添加实验室</u-button>
					</u-cell-item>
					<u-cell-item :title="'共有'+closeRoomList.length+'间实验室已关闭'" :arrow="false" v-else-if="currentLabTabs == 2">
						<view slot="icon" class="cuIcon-discover padding-right-sm  text-blue"></view>
						<u-button slot="right-icon" type="primary" :ripple="true" :plain="true" size="mini" @click="readyAddRoom" v-if="userInfo.level == 1">添加实验室</u-button>
					</u-cell-item>

					<u-cell-item :title="'共有'+myAdminRoomList.length+'间我管理的实验室'" :arrow="false" v-if="currentLabTabs == 3&&userInfo!=null">
						<view slot="icon" class="cuIcon-discover padding-right-sm  text-blue"></view>
					</u-cell-item>

					<navigator url="../profile/profile" open-type="switchTab" v-else-if="currentLabTabs == 3&&userInfo == null">
						<u-cell-item title="您还未实名绑定无法获取" value="去实名绑定" :arrow="false">
							<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
						</u-cell-item>
					</navigator>

				</u-cell-group>
			</view>


		</u-sticky>



		<!-- 实验室 -->
		<block v-if="currentTabs == 0">
			<!-- 添加教室 -->
			<!-- 			<drag-button :isDock="true" :existTabBar="true" @btnClick="readyAddRoom">
				<view slot="icon" class="text-xxl">
					<text class=" cuIcon-add "></text>
				</view>
			</drag-button> -->


			<u-popup v-model="showReadyAddRoom" length="50%" mode="top" border-radius="40">
				<u-toast ref="uToast_mask" />

				<view style="position: absolute;bottom: 0;width: 100%;">
					<u-cell-group>
						<u-field v-model="form_roomName" label="名称" icon="bookmark" icon-color="green" placeholder="全名请勿重复"
						 :error-message="roomNameErrorMsg" name="form_roomName" @blur="checkRoom">
						</u-field>
					</u-cell-group>

					<u-cell-group>
						<u-field v-model="form_roomAddress" label="地址" icon="map" icon-color="blue" placeholder="详细地址" name="form_notice"
						 type="textarea">
						</u-field>
					</u-cell-group>
					<!-- <textarea v-model="form_notice" maxlength="-1" placeholder="填写实验室地址"></textarea> -->
					<u-button @click="showConfirm" type="primary" plain :ripple="true">确认添加</u-button>
					<u-button @click="showReadyAddRoom = false" type="error" plain :ripple="true">取消</u-button>
				</view>
			</u-popup>


			<!-- 显示添加实验室 -->
			<!-- 			<view class="cu-modal" :class="modalName=='showReadyAddRoom'?'show':''">
				<view class="cu-dialog">
					<u-toast ref="uToast_mask" />
					<view class="cu-bar bg-white justify-end">
						<view class="content">添加实验室</view>
						<view class="action" @tap="hideModal">
							<text class="cuIcon-roundclose text-red text-sl"></text>
						</view>
					</view>
					<form>
						<u-cell-group>						
							<u-field v-model="form_roomName" label="名称" icon="bookmark" icon-color="green" placeholder="全名请勿重复"
							 :error-message="roomNameErrorMsg" name="form_roomName" @blur="checkRoom">
							</u-field>
							</u-cell-group>

							<u-cell-group>
							<u-field v-model="form_roomAddress" label="地址" icon="map" icon-color="blue" placeholder="实验室地址" :error-message="addressErrorMsg"
							 name="form_roomAddress" @blur="checkRoom">
							</u-field>
							</u-cell-group>


							<u-button @click="showConfirm" type="primary" plain :ripple="true" style="padding-top: 5rpx;">确认</u-button>
						</u-cell-group>
					</form>

				</view>
			</view> -->


			<!-- 最后确认添加教室 -->
			<view class="cu-modal" :class="modalName=='showConfirmAdd'?'show':''">
				<!-- 未绑定 -->
				<view class="cu-dialog">
					<view class="cu-bar bg-white justify-end">
						<view class="content">确认信息</view>
					</view>
					<u-cell-group>
						<u-cell-item :arrow="false" :center="true" title="实验室名称" :value="form_roomName">
							<u-icon slot="icon" size="32" color="green" name="bookmark"></u-icon>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="实验室地址" :value="form_roomAddress">
							<u-icon slot="icon" size="32" color="blue" name="map"></u-icon>
						</u-cell-item>
					</u-cell-group>

					<view class="flex">
						<view class="flex-sub ">
							<u-button @click="readyAddRoom" type="primary" plain :ripple="true">返回</u-button>
						</view>
						<view class="flex-sub ">
							<u-button @click="confirmAddRoom" type="success" plain :ripple="true">确认</u-button>
						</view>
					</view>
				</view>
			</view>

			<!-- 所有实验室列表和已开放未开放 -->
			<view class="cu-card bg-white" v-if="currentLabTabs < 3">
				<block v-if="currentLabTabs == 0">
					<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
					 style="height: 180upx;" v-for="(item,index) in roomList" :key="index" @click="toRoomDetail" :data-rid="item.rid"
					 :data-rname="item.rname" :data-address="item.address" :data-del="item.del">
						<navigator>
							<view class="flex solid-bottom justify-between">
								<view class="padding-left-xl padding-top-sm text-white">
									<view class=" text-xxl text-bold">
										{{item.rname}}
									</view>
									<view class="padding-top-xs text-lg">
										<!-- 										<view class="cu-capsule radius shadow-blur">
											<view class="cu-tag sm bg-blue" ><text class='cuIcon-location'></text></view>
											<view class="cu-tag sm line-white text-white" >{{item.rname}}</view>
										</view> -->

										<u-button type="primary" :ripple="true" size="mini"><text class='cuIcon-location'></text>{{item.address}}</u-button>

									</view>
								</view>
								<u-tag text="已开放" type="success" mode="dark" v-if="item.del == 1" />
								<u-tag text="已关闭" type="error" mode="dark" v-else />
							</view>
						</navigator>
					</view>
					<u-empty text="实验室为空" mode="list" v-if="roomList.length == 0"></u-empty>
				</block>

				<block v-else-if="currentLabTabs == 1">
					<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
					 style="height: 180upx;" v-for="(item,index) in openRoomList" :key="index" @click="toRoomDetail" :data-rid="item.rid"
					 :data-rname="item.rname" :data-address="item.address" :data-del="item.del">
						<navigator>
							<view class="flex solid-bottom justify-between">
								<view class="padding-left-xl padding-top-sm text-white">
									<view class=" text-xxl text-bold">
										{{item.rname}}
									</view>
									<view class="padding-top-xs text-lg">

										<u-button type="primary" :ripple="true" size="mini"><text class='cuIcon-location'></text>{{item.address}}</u-button>
									</view>
								</view>
								<u-tag text="已开放" type="success" mode="dark" v-if="item.del == 1" />
								<u-tag text="已关闭" type="error" mode="dark" v-else />
							</view>
						</navigator>
					</view>
					<u-empty text="还没有已开放的实验室" mode="list" v-if="openRoomList.length == 0"></u-empty>
				</block>

				<block v-else-if="currentLabTabs == 2">
					<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
					 style="height: 180upx;" v-for="(item,index) in closeRoomList" :key="index" @click="toRoomDetail" :data-rid="item.rid"
					 :data-rname="item.rname" :data-address="item.address" :data-del="item.del">
						<navigator>
							<view class="flex solid-bottom justify-between">
								<view class="padding-left-xl padding-top-sm text-white">
									<view class=" text-xxl text-bold">
										{{item.rname}}
									</view>
									<view class="padding-top-xs text-lg">

										<u-button type="primary" :ripple="true" size="mini"><text class='cuIcon-location'></text>{{item.address}}</u-button>
									</view>
								</view>
								<u-tag text="已开放" type="success" mode="dark" v-if="item.del == 1" />
								<u-tag text="已关闭" type="error" mode="dark" v-else />
							</view>
						</navigator>
					</view>
					<u-empty text="还没有已关闭的实验室" mode="list" v-if="closeRoomList.length == 0"></u-empty>
				</block>
			</view>


			<!-- 管理的实验室列表 -->
			<view class="cu-card bg-white" v-if="currentLabTabs == 3">
				<view class="cu-item shadow-blur bg-img bg-mask flex align-center" :style="{backgroundImage:'url(http://mp-images.test.upcdn.net/lab'+index%4+'.jpg)'}"
				 style="height: 180upx;" v-for="(item,index) in myAdminRoomList" :key="index" @click="toRoomDetail" :data-rid="item.rid"
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

		<!-- 用户 -->
		<block v-else-if="currentTabs == 1">

			<block v-if="userInfo.level == 1">
				<navigator url="user">
					<view class="cu-card bg-white">
						<view class="cu-item shadow-blur bg-img bg-mask flex align-center" style="background-image: url(http://mp-images.test.upcdn.net/%E7%BD%AE%E9%A1%B6%E5%9B%BE.jpg);height: 200upx;">
							<view class="flex solid-bottom justify-between">
								<view class="padding-left-xl padding-top-lg text-white">
									<view class=" text-xxl text-bold">
										用户索引列表
									</view>
								</view>
							</view>
						</view>
					</view>
				</navigator>
			</block>

			<block v-else>
				<u-cell-group>
					<navigator url="../profile/profile" open-type="switchTab">
						<u-cell-item :arrow="true" title="只有超级管理员能查看" value="去成为超级管理员">
							<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
						</u-cell-item>
					</navigator>
				</u-cell-group>

			</block>




		</block>

		<!-- 日志 -->
		<block v-if="currentTabs == 2">
			<block v-if="userInfo.level != 1">
				<u-cell-group>
					<navigator url="../profile/profile" open-type="switchTab">
						<u-cell-item :arrow="true" title="您只能查看您管理的实验室的日志" value="去成为超级管理员">
							<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
						</u-cell-item>
					</navigator>
				</u-cell-group>

			</block>

			<block v-else>
				<!-- 日历选择 -->
				<u-calendar v-model="isCale" mode="range" safeAreaInsetBottom="true" @change="getAllLog" :closeable="false">
					<view slot="tooltip" style="text-align: center;">
						<u-button type="primary" shape="circle" size="default" :ripple="true" @click="getAllLog2">查看所有</u-button>
					</view>
				</u-calendar>
				<!-- 选择日期 -->
				<!-- <u-back-top @tap="showCale" :scroll-top="scrollTop" mode="square" top="0" right="28" bottom="5" icon="calendar"></u-back-top> -->

				<!-- 				<drag-button :isDock="true" :existTabBar="true" @btnClick="showCale">
					<view slot="icon" class="text-xxl">
						<text class=" cuIcon-calendar"></text>
					</view>
				</drag-button> -->

				<u-empty text="还没有日志" mode="message" v-if="logList.length == 0"></u-empty>
				<view class="cu-timeline">
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
										<view slot="title" class="text-black text-bold text-sm padding-left-sm">{{item.user.realName}}通过指纹{{item.status==1?'进入':'离开'}}</br>

											<view class="cu-capsule radius shadow-blur">
												<view class="cu-tag sm " :class="item.status==1?'bg-green':'bg-blue'"><text class='cuIcon-location'></text></view>
												<view class="cu-tag  sm" :class="item.status==1?'line-green':'line-blue'">{{item.room.rname}}</view>
											</view>

										</view>
										<view slot="icon" class="cu-avatar radius shadow-blur" :class="item.status==1?'bg-green':'bg-blue'" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}"></view>
										<u-button slot="right-icon" :type="item.status==1?'success':'primary'" :ripple="true" :plain="true" size="mini">{{item.status==1?'进入':'离开'}}
										</u-button>

									</u-cell-item>

								</u-cell-group>
							</view>
						</view>
					</block>
				</view>


			</block>
		</block>



		<!-- </scroll-view> -->




		<!-- 从抽屉返回主页面 -->
		<!-- 		<view class="DrawerClose" :class="modalName=='showDrawer'?'show':''" @tap="hideModal">
			<text class="cuIcon-pullright"></text>
		</view> -->


		<!-- 抽屉界面，房间日志 -->
		<!-- 		<scroll-view scroll-y class="DrawerWindow bg-white" :class="modalName=='showDrawer'?'show':''" v-if="modalName == 'showDrawer'">

			
			
			<u-tabs ref="tabs" :list="roomDetailTabsList"  :bold="true" :is-scroll="false" :current="currentLabTabs" @change="labTabsChange" height="60" font-size="25"  v-if="currentTabs==0"></u-tabs>
			
			
			
		</scroll-view> -->









	</view>
</template>

<script>
	import dragButton from "@/components/drag-button/drag-button.vue";
	import moment from 'moment'
	export default {
		components: {
			dragButton
		},
		data() {
			return {
				head_style: {
					size: '500rpx',
					color: 'blue',
					padding: '10rpx'
				},
				forList: [1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ],
				// 样式data
				collapse:true,
				showReadyAddRoom: false,
				isCale: false,
				scrollTop: 0,
				modalName: null,
				currentTabs: 0,
				currentLabTabs: 0,
				tabsList: [{
					name: '实验室'
				}, {
					name: '用户'
				}, {
					name: '日志'
				}],
				roomTabsList: [{
					name: '所有实验室'
				}, {
					name: '已开放'
				}, {
					name: '已关闭'
				}, {
					name: '我管理的'
				}],
				roomDetailTabsList: [{
					name: '日志'
				}, {
					name: '公告'
				}, {
					name: '成员'
				}, {
					name: '文件'
				}],

				// 消息未读数量

				//数据data
				openRoomList: null,
				closeRoomList: null,
				form_roomName: null,
				form_roomAddress: null,
				roomNameErrorMsg: '',
				addressErrorMsg: '',

				roomList: null,
				myAdminRoomList: null,


				isAllLog: true,
				startDate: null,
				endDate: null,
				logList: null,
				userInfo: null,
				wxuserInfo: null
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onShow() {

			var that = this
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			/* global.getUserInfo() */
			that.userInfo = uni.getStorageSync("userInfo")

			// 根据离开页面来判定重新加载什么
			if (that.currentTabs == 0) {
				if (that.currentLabTabs < 3) {
					that.getAllRoomList()
				} else if (that.currentLabTabs == 3) {
					that.getAllAdminRoolList()
				}
			} else if (that.currentTabs == 1) {} else if (that.currentTabs == 2) {

				/* var e = {}
				e.startDate = null
				e.endDate = null
				that.getAllLog(e) */
			}

		},
		methods: {
			// 去实验室索引列表
			toRoomDetail(e) {
				var that = this
				var rid = e.currentTarget.dataset.rid
				var rname = e.currentTarget.dataset.rname
				var address = e.currentTarget.dataset.address
				var del = e.currentTarget.dataset.del


				if (that.currentLabTabs != 3 && that.userInfo.level != 1) {
					that.showToast("只有超管或此实验室管理员有权查看", "warning", "bottom")
					return false
				} else {
					uni.navigateTo({
						url: "room?rid=" + rid + '&rname=' + rname + '&address=' + address + '&del=' + del
					})
				}


			},

			// 去用户索引列表
			toUserList() {
				var that = this
				if (that.userInfo.level != 1) {
					that.showToast("只有超级管理员能查看", "error", "bottom")
					return false
				} else {
					uni.navigateTo({
						url: "user"
					})
				}

			},

			// 样式控制方法
			// 打开modal
			showModal(e) {
				this.modalName = e.currentTarget.dataset.modal
			},
			hideModal(e) {
				this.modalName = null
			},

			// 一级菜单
			tabsChange(index) {
				var that = this

				// 实验室
				if (index == 0) {
					if (that.currentLabTabs < 3) {
						that.getAllRoomList()
					} else if (that.currentLabTabs == 3) {
						that.getAllAdminRoolList()
					}
				}
				// 日志
				else if (index == 2 && that.isAllLog == true) {
					that.collapse = false
					var e = {}
					e.startDate = null
					e.endDate = null				
					that.getAllLog(e)
				}else if(index == 1){
					that.collapse = false
				}
				that.currentTabs = index

			},

			/* 实验室界面tabs栏 */
			labTabsChange(index) {
				var that = this
				that.currentLabTabs = index;
				if (index < 3) {
					that.getAllRoomList()
				} else if (index == 3) {
					that.getAllAdminRoolList()
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
			showToast_mask(title, type, position) {
				this.$refs.uToast_mask.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			},


			showCale() {
				this.isCale = true
			},


			// 点击添加按钮
			readyAddRoom() {
				var that = this
				if (that.userInfo.level == 1) {
					that.showReadyAddRoom = that.showReadyAddRoom == true ? false : true
					that.hideModal()
				} else {
					that.showToast("只有超级管理员能添加实验室", "warning", "bottom")
				}

			},
			// 动态检查是否重复
			checkRoom() {
				var that = this
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/checkRoom",
					data: {
						rname: that.form_roomName,
						address: that.form_roomAddress
					},
					success(res) {
						var rname = res.data.room_rname
						var address = res.data.room_address
						console.log(res)
						if (rname != null || address != null) {
							if (that.form_roomName != null) {
								that.roomNameErrorMsg = "实验室名称重复"
								that.showToast_mask("实验室名称重复", "error", "bottom")
							}
							if (that.form_roomAddress != null) {
								that.roomNameErrorMsg = "地址重复"
								that.showToast_mask("实验室地址重复", "error", "bottom")
							}
						} else {
							that.roomNameErrorMsg = ""
							that.roomNameErrorMsg = ""
							if (that.form_roomName != null) {
								console.log("可用")

								that.showToast_mask("实验室名称可用", "success", "bottom")
							}
							if (that.form_roomAddress != null) {
								console.log("可用")

								that.showToast_mask("实验室地址可用", "success", "bottom")
							}

						}
					}

				})
			},
			// 显示确认界面
			showConfirm() {
				var that = this
				if (that.form_roomName == null || that.form_roomAddress == null) {
					that.showToast_mask("请填写完整信息", "warning", "bottom")
					return false
				} else {
					that.showReadyAddRoom = false
					that.modalName = 'showConfirmAdd'
				}

			},
			// 返回添加输入界面
			returnAddRoom() {
				var that = this
				that.showReadyAddRoom = true
				that.hideModal()
			},
			// 最后确定添加教室
			confirmAddRoom() {
				var that = this
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/insertRoom",
					data: {
						uid: that.userInfo.uid,
						rname: that.form_roomName,
						address: that.form_roomAddress
					},
					success(res) {
						console.log(res)
						that.hideModal()
						that.getAllRoomList()
						that.showToast("添加实验室成功", "success", "bottom")

					}
				})
			},


			// 调用接口方法集
			getAllLog(e) {
				var that = this
				var startDate = e.startDate
				var endDate = e.endDate
				uni.request({
					url: "http://47.100.59.153:8885/MP/log/getLog",
					data: {},
					success(res) {
						console.log(res)
						that.logList = res.data.logList

						if (startDate != null && endDate != null) {
							console.log("选择日期模式")
							var logList_2 = []
							for (let i = 0; i < that.logList.length; i++) {
								let ldate = moment(that.logList[i].ldate).format('YYYY-MM-DD')
								if (moment(ldate).isBefore(e.startDate) == false && moment(ldate).isAfter(e.endDate) == false) {
									console.log("符合条件" + that.logList[i])
									logList_2.push(that.logList[i])
								}
							}
							that.isAllLog = false
							that.logList = logList_2
							that.startDate = startDate
							that.endDate = endDate
							
							uni.pageScrollTo({
								scrollTop: 0,
								duration: 100
							});
							
							that.showToast("获取从" + startDate + "到" + endDate + "的日志成功", "success", "bottom")
						} else {
							that.isAllLog = true
							that.startDate = moment(that.logList[that.logList.length - 1].ldate).format('YYYY-MM-DD')
							that.endDate = moment(that.logList[0].ldate).format('YYYY-MM-DD')
							
							uni.pageScrollTo({
								scrollTop: 0,
								duration: 100
							});
							
							that.showToast("获取所有用户日志成功", "success", "bottom")
						}
						that.isCale = false
					}
				})
			},
			getAllLog2() {
				var that = this
				var e = {}
				e.startDate = null
				e.endDate = null
				that.getAllLog(e)
			},
			// 获取所有房间
			getAllRoomList() {
				uni.showLoading({
					title: '正在加载控制台'
				})
				var that = this
				// 超管获取所有房间
				uni.request({
					url: "http://47.100.59.153:8885/MP/public/getRoomList",
					data: {

					},
					success(res) {
						console.log(res)
						var openRoomList = []
						var closeRoomList = []
						that.roomList = res.data.roomList
						for (let i = 0; i < that.roomList.length; i++) {
							if (that.roomList[i].del == 1) {
								openRoomList.push(that.roomList[i])
							} else if (that.roomList[i].del == 0) {
								closeRoomList.push(that.roomList[i])
							}
						}
						that.openRoomList = openRoomList
						that.closeRoomList = closeRoomList

						uni.hideLoading()
						that.showToast("获取所有实验室成功", "success", "bottom")
					}
				})
			},

			// 获取我管理的房间
			getAllAdminRoolList() {
				uni.showLoading({
					title: '正在加载我管理的实验室'
				})
				var that = this
				if (that.userInfo != null) {
					uni.request({
						url: "http://47.100.59.153:8885/MP/admin/getRoomByAdmin",
						data: {
							uid: that.userInfo.uid
						},
						success(res) {
							console.log(res)
							that.myAdminRoomList = res.data.myAdminRoomList

							that.showToast("获取我管理的实验室成功", "success", "bottom")
						}
					})
				}

				uni.hideLoading()
			}
		}
	}
</script>

<style>
	/* 抽屉样式 */
	.DrawerPage {
		position: absolute;
		width: 100vw;
		height: 100%;
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
