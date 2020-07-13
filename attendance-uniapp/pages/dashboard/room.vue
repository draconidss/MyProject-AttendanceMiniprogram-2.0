<template>
	<view>
		<u-toast ref="uToast" />



		<!-- <view style="position: fixed;z-index:50;top: 200rpx;">
			
		</view> -->
		
		<!-- 显示添加公告 -->
		<!-- close-icon-pos="bottom-right" :closeable="true" -->
						<u-popup v-model="showReadyAddNotice"  length="50%" mode="top" border-radius="40" >
								<!-- <textarea v-model="form_notice" maxlength="-1" :placeholder="'添加公告信息在'+rname"></textarea> -->
								
								<view style="position: absolute;bottom: 0;width: 100%;">
								<u-cell-group >
									<u-field v-model="form_notice" label="公告" icon="chat" icon-color="blue"   :placeholder="'添加公告信息在'+rname" name="form_notice"   type="textarea" >
									</u-field>
								</u-cell-group>
								<u-button @click="addNotice" type="primary" plain  :ripple="true" style="padding-top: 5rpx;width: 40%;" >确认添加</u-button>
								<u-button @click="showReadyAddNotice = false" type="error" plain  :ripple="true" style="padding-top: 5rpx;width: 40%;" >取消</u-button>
								</view>
									
							
						</u-popup>


		<!-- 抽屉主界面 -->
		<scroll-view scroll-y class="DrawerPage" :class="modalName=='showChangeAdmin'?'show':''">


			<u-sticky>
				<view style="position: fixed;z-index: 99;">
					<cu-custom :isBack="true" bgColor="bg-shadeTop text-white">
						<block slot="backText">返回</block>
						<block slot="content">{{rname}}</block>
					</cu-custom>
				</view>

				<swiper class="screen-swiper round-dot " :indicator-dots="true" :circular="true" :autoplay="true" interval="5000"
				 duration="500">
					<swiper-item v-for="(item,index) in 3" :key="index">
						<image :src="'http://mp-images.test.upcdn.net/lab'+index+ '.jpg'" mode="aspectFill" class="bg-mask" style="height: 400upx;"></image>
					</swiper-item>
				</swiper>

				<!-- 仪表盘 -->
				<view class="cu-list grid col-5 shadow-lg">
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-red text-bold">
								{{memberInfo.length}}
							</view>
							<view class="margin-top-sm text-grey text-xs">总成员</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-blue text-bold">
								{{onlineMember.length}}
							</view>
							<view class="margin-top-sm text-grey text-xs">在实验室</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-cyan text-bold">
								{{offlineMember.length}}
							</view>
							<view class="margin-top-sm text-grey text-xs">不在实验室</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-green text-bold">
								{{roomLogInfo_len}}
							</view>
							<view class="margin-top-sm text-grey text-xs">总日志数</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-df text-red text-bold " v-if="del == 0">
								关闭
							</view>
							<view class="text-df text-green text-bold " v-else>
								开放
							</view>
							<view class="margin-top-sm text-grey text-xs">状态</view>
						</view>
					</view>
				</view>


				<view class="shadow bg-blue">

					<u-subsection :bold="true" :list="tabsList" :current="currentTab" @change="tabsChange" button-color="#0081ff"
					 active-color="white" />

					<!-- 日志统计 -->
					<u-cell-group v-if="startDate!=null&&endDate!=null&&currentTab == 0">
						<u-cell-item :title="'从'+startDate+'到'+endDate" :value="'共'+roomLogInfo_len2+'条日志'" :arrow="true" @tap="showCale">
							<view slot="icon" class="cuIcon-calendar padding-right-sm text-blue"></view>
						</u-cell-item>
					</u-cell-group>

					<!-- 公告二级菜单 -->
					<u-tabs ref="tabs" :list="noticeTabsList" :bold="true" :is-scroll="false" :current="currentNoticeTab" @change="noticeTabsChange"
					 height="60" font-size="25" arrow-direction="down" v-else-if="currentTab==1" />

				</view>


			</u-sticky>

			<!-- 日志 -->
			<block v-if="currentTab == 0">

				<u-empty text="还没有日志" mode="message" v-if="roomLogInfo.length == 0"></u-empty>
				<block v-else>
					<!-- 日期筛选器 -->
					<u-calendar v-model="isCale" mode="range" safeAreaInsetBottom="true" @change="getRoomDetail" :closeable="false">
						<view slot="tooltip" style="text-align: center;">
							<u-button type="primary" shape="circle" size="default" :ripple="true" @click="getRoomDetail2">查看所有</u-button>
						</view>
					</u-calendar>

					<drag-button :isDock="true" :existTabBar="true" @btnClick="showCale" style="z-index: 20;">
						<view slot="icon" class="text-xxl">
							<text class=" cuIcon-calendar "></text>
						</view>
					</drag-button>


					<!-- 日志 -->

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
					<u-divider half-width="250">没有更多了</u-divider>
				</block>


			</block>

			<!-- 公告 -->
			<block v-else-if="currentTab == 1">
				<!-- 添加公告 -->
				<drag-button :isDock="true" :existTabBar="true" @btnClick="readyAddNotice">
					<view slot="icon" class="text-xxl">
						<text class=" cuIcon-add "></text>
					</view>
				</drag-button>



				<!-- 公告列表 -->

				<!-- 未删除公告 -->
				<view class="cu-card dynamic solids" v-for="(item,index) in adminInfo " :key="index" v-if="currentNoticeTab == 0&&item.del == 1">
					<view class="cu-item shadow-warp">
						<view class="cu-list menu-avatar">
							<view class="cu-item">
								<view class="cu-avatar radius lg shadow-blur" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}">
									<view class="cu-tag badge radius" v-if="item.user.level == 1">超管</view>
									<view class="cu-tag badge radius" v-else>管</view>
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
							<button type="warn" size="mini" :ripple="true" :data-aid="item.aid" @click="deleteNotice" v-if="userInfo.uid == item.uid">删除</button>
						</view>
					</view>
				</view>

				<!-- 已删除公告 -->
				<view class="cu-card dynamic solids" v-for="(item,index) in adminInfo " :key="index" v-if="currentNoticeTab == 1&&item.del == 0">
					<view class="cu-item shadow-warp">
						<view class="cu-list menu-avatar">
							<view class="cu-item">
								<view class="cu-avatar radius lg shadow-blur" :style="{backgroundImage:'url('+item.wxuser.avatarUrl+')'}">
									<view class="cu-tag badge radius" v-if="item.user.level == 1">超管</view>
									<view class="cu-tag badge radius" v-else>管</view>
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

					</view>
				</view>

				<u-empty text="还没有公告" mode="message" v-if="adminInfo.length ==0"></u-empty>

			</block>

			<!-- 成员 -->
			<block v-else-if="currentTab == 2">
				<view class="padding-sm bg-white">
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


			</block>

			<!-- 文件 -->
			<block v-else-if="currentTab == 3">
				<u-cell-group class="margin-top shadow-lg">

					<u-cell-item :arrow="false" value="05-15" @click="showToast('该功能开发中,敬请期待','primary','bottom')">
						<view slot="title" class="text-black text-bold text-sm padding">{{rname}}注意事项.word</br><text class="text-grey text-xs">来自{{userInfo.realName}}</text></text></view>
						<view slot="icon" class="cu-avatar radius shadow-blur" style="background-image: url('http://mp-images.test.upcdn.net/word2.png')">
							<!-- <view class="cu-tag badge lg">{{index+1}}</view> -->
						</view>
						<!-- <view slot="right-icon" class="text-black text-bold text-lg">{{item.allDuration | dataFormat("duration")}}</view> -->
					</u-cell-item>

				</u-cell-group>

				<!-- 			<view class="cu-card dynamic solids">
				<view class="cu-item shadow">
					<view class="cu-list menu-avatar">
						<view class="cu-item">
							<view class="cu-avatar radius xxl shadow-blur" :style="{backgroundImage:'url('+wxuserInfo.avatarUrl+')'}">
							</view>
							<view class="content flex-sub text-xs">
								<view class="text-bold text-black">{{wxuserInfo.nickName}}</view>
								<view class="text-gray text-xs flex justify-between">
									2020-06-15 12:05:20
								</view>
							</view>
						</view>
					</view>
					<view class="padding-sm text-sm">
						{{rname}}注意事项.txt
					</view>
					<view class="text-gray text-sm text-right padding-xs">
						<text class="cuIcon-attentionfill margin-lr-xs"></text>5人已读
					</view>
				</view>
			</view> -->
			</block>

			<!-- 设置 -->
			<block v-else-if="currentTab == 4">
				<view class="cu-list card-menu shadow margin-top" v-if="userInfo.level == 1">
					<u-cell-group>
						<u-cell-item :arrow="false" :center="true" title="设置管理员" @click="showAdmin">
							<view slot="icon" class="cuIcon-peoplelist padding-right-sm text-orange"></view>
							<view class="action" slot="right-icon" v-if="adminMember.length > 0">
								<view class="cu-avatar-group">
									<block v-for="(item,index) in adminMember" :key="index">
										<view class="cu-avatar round sm" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]" v-if="index<4"></view>
									</block>
								</view>
								<text class="text-grey text-sm">等{{adminMember.length}}人<text class="cuIcon-right padding-left-xs text-grey" /></text>
								<!-- <view  class="cuIcon-right padding-left-sm text-grey"></view> -->
							</view>

							<view class="action" slot="right-icon" v-else>
								<text class="text-grey text-sm">无管理员<text class="cuIcon-right padding-left-xs text-grey" /></text>
							</view>

						</u-cell-item>
					</u-cell-group>
					<u-grid :col="2">
						<u-grid-item @click="showChangeAdmin" :index="0">
							<view class=" text-xxl ">
								<text class=" cuIcon-friendadd text-green "></text>
							</view>
							<view class="grid-text text-sm">添加管理员</view>
						</u-grid-item>
						<u-grid-item @click="showChangeAdmin" :index="1">
							<view class=" text-xxl ">
								<text class=" cuIcon-my text-red "></text>
							</view>
							<view class="grid-text text-sm">删除管理员</view>
						</u-grid-item>
					</u-grid>
				</view>


				<view class="cu-list card-menu shadow margin-top">
					<u-cell-group>
						<u-cell-item :arrow="false" :center="true" title="实验室rid" :value="rid">
							<!-- <u-icon slot="icon" size="32" color="yellow" name="star"></u-icon> -->
							<view slot="icon" class="cuIcon-title padding-right-sm text-green"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="实验室名称" :value="rname">
							<view slot="icon" class="cuIcon-home padding-right-sm text-blue"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="地址" :value="address">
							<view slot="icon" class="cuIcon-location padding-right-sm text-red"></view>
						</u-cell-item>
						

						<u-cell-item :arrow="false" :center="true" title="查看监控" value="TODO" @click="showToast('该功能开发中，敬请期待','primary','bottom')">
							<view slot="icon" class="cuIcon-attention padding-right-sm text-black"></view>
						</u-cell-item>

						<u-cell-item :arrow="false" :center="true" title="是否开放">
							<view slot="icon" class="cuIcon-attention padding-right-sm text-cyan"></view>
							<u-switch slot="right-icon" active-color="success" v-model="checkedDel" @click="changeRoomStatus"></u-switch>
						</u-cell-item>
					</u-cell-group>
				</view>
			</block>

		</scroll-view>

		<!-- 从抽屉返回主页面 -->
		<view class="DrawerClose" :class="modalName=='showChangeAdmin'?'show':''" @tap="hideModal">
			<text class="cuIcon-pullright"></text>
		</view>



		<!-- 抽屉界面，房间日志 -->
		<scroll-view scroll-y class="DrawerWindow bg-white" :class="modalName=='showChangeAdmin'?'show':''">

			<u-sticky>
				<u-subsection :bold="true" :list="adminTabList" :current="currentAdminTab" @change="adminTabsChange" button-color="#0081ff"
				 active-color="white" />
			</u-sticky>

			<u-index-anchor index="管理员" class="padding-top " />			
			<view class="cu-list grid col-6 no-border" >
				<view class="cu-item padding-right-sm" v-for="(item,index) in adminMember" :key="index">
					<block v-if="item.isAdmin == 1">
						<view class="cu-avatar radius lg margin-sm shadow-blur" :style="[{ backgroundImage:'url(' + item.wxuser.avatarUrl+ ')' }]">
							<view class="cu-tag badge radius" v-if="item.user.level == 1">超管</view>
							<view class="cu-tag badge radius" v-else>管</view>
						</view>
						<text>{{item.user.realName}}</text>
					</block>
				</view>
			</view>


			<!-- 添加管理员 -->
			<block v-if="currentAdminTab == 0">

				<u-index-list :scrollTop="scrollTop" :index-list="indexList">
					<view v-for="(item, index) in indexList" :key="index">
						<u-index-anchor :index="item" class="padding-top " />
						<u-cell-group class="shadow-lg">
							<u-cell-item :arrow="false" v-for="(item2,index2) in userList" :key="index2" @click="changeAdmin(item2.user)"
							 v-if="item2.index == item">
								<view slot="title" class="text-black text-bold text-lg padding-xs">{{item2.user.realName}}<text class="text-grey">
										({{item2.nickName}})</text></view>
								<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item2.avatarUrl+')'}">
									<view class="cu-tag badge " v-if="item2.user.level == 1">超管</view>
								</view>
								<u-button slot="right-icon" type="success" :ripple="true" :plain="true" size="mini"  @click="changeAdmin(item2.user)">添加</u-button>
							</u-cell-item>
						</u-cell-group>
					</view>
				</u-index-list>
			</block>

			<!-- 删除管理员 -->
			<block v-else>
				<u-empty text="还没有管理员" mode="list" v-if="adminMember.length == 0"></u-empty>
				<block v-else>
					<u-index-anchor index="删除管理员" class="padding-top " />
					<u-cell-group class="shadow-lg">
						<u-cell-item :arrow="false" v-for="(item2,index2) in adminMember" :key="index2" @click="changeAdmin(item2.user)">
							<view slot="title" class="text-black text-bold text-lg padding-xs">{{item2.user.realName}}<text class="text-grey">
									({{item2.wxuser.nickName}})</text></view>
							<view slot="icon" class="cu-avatar radius shadow-blur" :style="{backgroundImage:'url('+item2.wxuser.avatarUrl+')'}">
								<view class="cu-tag badge radius" v-if="item2.user.level == 1">超管</view>
							</view>
							<u-button slot="right-icon" type="error" :ripple="true" :plain="true" size="mini" @click="changeAdmin(item2.user)">删除</u-button>
						</u-cell-item>
					</u-cell-group>
				</block>

			</block>



		</scroll-view>


	</view>
</template>

<script>
	import moment from 'moment'
	import {
		initial
	} from '../../libs/chineseConversion.js'
	export default {
		data() {
			return {
				index:0,
				isSticky: false,
				showReadyAddNotice: false,
				checkedDel: false,
				rid: null,
				rname: null,
				del: null,
				address: null,
				startDate: null,
				endDate: null,
				isCale: false,
				roomLogInfo_len: 0,
				roomLogInfo_len2: 0,
				memberInfo: [],
				roomLogInfo: [],
				adminInfo: [],
				onlineMember: [],
				offlineMember: [],
				adminMember: [],

				modalName: null,
				form_notice: null,

				roomDetailInfo: null,
				wxuserInfo: null,
				userInfo: null,
				currentTab: 0,
				currentNoticeTab: 0,
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
				noticeTabsList: [{
					name: '可用公告'
				}, {
					name: '已删除'
				}],
				// 用户索引
				indexList: [],
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
				userList: [],
				scrollTop: 0,
				currentAdminTab: 0,
				adminTabList: [{
					name: '添加管理员'
				}, {
					name: '删除管理员'
				}]
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		onLoad: function(option) {
			var that = this
			console.log(option)
			that.rid = parseInt(option.rid)
			that.del = parseInt(option.del)
			that.rname = option.rname
			that.address = option.address

			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")

			var e = {}
			e.startDate = null
			e.endDate = null
			that.getRoomDetail(e)

		},
		watch: {
			checkedDel(newValue, oldValue) {
				console.log("new" + newValue)
				console.log("old" + oldValue)
				this.changeRoomStatus(newValue, oldValue)
			}
		},
		methods: {
			adminTabsChange(index) {
				var that = this
				that.showChangeAdmin(index)
			},


			// 添加管理员			
			changeAdmin(index) {
				console.log(index)
				var that = this				
				var user = index
				var method = that.currentAdminTab == 0 ? 1 : 0
				var title = ''
				// 添加用户
				if (method == 1) {
					title = "确定将" + user.realName + "设为" + that.rname + "的管理员?"
				} else {
					title = "确定删除" + that.rname + "的管理员" + user.realName + "?"
				}
				uni.showModal({
					title: title,
					success: function(res) {
						if (res.confirm) {
							console.log("确定了")
							uni.request({
								url: "http://47.100.59.153:8885/MP/admin/addOrDelAdmin",
								data: {
									rid: that.rid,
									uid: user.uid,
									method: method
								},
								success(res) {
									console.log(res)
									var e = {}
									e.startDate = null
									e.endDate = null
									e.refresh = true
									that.getRoomDetail(e)
									
									setTimeout(function () {									
									if (res.data.code == 200) {
										that.showChangeAdmin(0)	
										that.showToast("添加管理员成功", "success", "bottom")
									} else if (res.data.code == 201) {
										that.showChangeAdmin(1)	
										that.showToast("删除管理员成功", "success", "bottom")
									}
									}, 300);				
									

								}
							})
						}
					}
				})
			},
			// 添加删除管理员时的获取用户列表
			showChangeAdmin(index) {
				var that = this
				console.log(index)
				that.modalName = "showChangeAdmin"
				that.currentAdminTab = index
				uni.showLoading({
					title: '正在加载用户'
				})
				// 初始化索引
				for (let item of that.indexList_temp) {
					item.index = 0
				}

				// 添加用户
				if (that.currentAdminTab == 0) {
					uni.request({
						url: "http://47.100.59.153:8885/MP/admin/getAllUser",
						data: {},
						success(res) {
							console.log(res)
							that.userList = []
							var userList = []
							userList = res.data.userList
							console.log("userList:::"+userList)
							
							if (that.adminMember.length != 0) {
								for (let item of userList) {
									for (let item1 of that.adminMember) {
										if (item.uid == item1.uid) {
											item.uid = null
										}
									}
								}
																
							}
							
							for(let item of userList){
								if(item.uid != null){
									that.userList.push(item)
								}
							}
							
							
							console.log(that.userList)

							that.indexList = []
							for (let item of that.userList) {
								item.index = initial(item.user.realName)
								for (let item2 of that.indexList_temp) {
									if (item2.value == item.index) {
										console.log("符合条件")
										if(item2.index != 1){
											item2.index = 1
											that.indexList.push(item2.value)
										}																				
									}
								}
							}
							console.log(that.indexList)
						}
					})
				}
				// 删除用户
				else if (that.currentAdminTab == 1) {
					var e = {}
					e.startDate = null
					e.endDate = null
					e.refresh = true
					that.getRoomDetail(e)
					that.indexList = []

				}
				uni.hideLoading()

			},
			showAdmin() {
				this.currentTab = 2
			},
			// 改变房间状态
			changeRoomStatus(newValue, oldValue) {
				var that = this
				var status = 0
				if (newValue == true) {
					status = 1
				}
				if (that.del == status) {
					return false
				} else {
					var title = "关闭"
					if (status == 1) {
						title = "开放"
					}
					uni.showModal({
						title: "您是否要" + title + that.rname,
						success: function(res) {
							if (res.cancel) {
								that.checkedDel = oldValue
								return false
							}
							if (res.confirm) {
								uni.request({
									url: "http://47.100.59.153:8885/MP/admin/changeRoomStatus",
									data: {
										uid: that.userInfo.uid,
										rid: that.rid,
										del: status
									},
									success(res) {
										console.log(res)
										if (res.data.code == 200) {
											that.showToast("实验室开放成功", "success", "bottom")
											that.checkedDel == newValue
											that.del = 1
										} else if (res.data.code == 201) {
											that.showToast("请确保实验室没有人员后再关闭", "warning", "bottom")
											that.checkedDel == oldValue
										} else if (res.data.code == 202) {
											that.showToast("实验室关闭成功", "success", "bottom")
											that.checkedDel == newValue
											that.del = 0
										}
										var e = {}
										e.startDate = null
										e.endDate = null
										e.refresh = true
										that.getRoomDetail(e)
									}
								})
							}
						},
					})
				}
			},
			/* 实验室界面tabs栏 */
			noticeTabsChange(index) {
				var that = this
				that.currentNoticeTab = index
			},
			// 打开日期筛选
			showCale() {
				this.isCale = true
			},
			// tabs栏切换
			tabsChange(index) {

				this.currentTab = index;
			},
			// 监听
			sectionChange(index) {
				this.currentTab = index;
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
			deleteNotice(e) {
				var that = this
				var aid = e.currentTarget.dataset.aid
				console.log("aid=" + aid)
				console.log("that.userInfo.uid=" + that.userInfo.uid)
				console.log("that.rid=" + that.rid)
				uni.showModal({
					title: "确定要删除这条公告吗",
					success: function(res) {
						if (res.confirm) {
							uni.request({
								url: "http://47.100.59.153:8885/MP/admin/addOrDeleteNotice",
								data: {
									aid: aid,
									uid: that.userInfo.uid,
									rid: that.rid,
									method: 0
								},
								success(res) {
									console.log(res)
									var e = {}
									e.startDate = null
									e.endDate = null
									e.refresh = true
									that.getRoomDetail(e)
									that.showToast("删除公告成功", "success", "bottom")
								}
							})
						}
					},
				})
			},


			readyAddNotice() {
				var that = this
				that.showReadyAddNotice = true
				/* uni.navigateTo({
					url:'addNotice?rid='+that.rid+'&uid='+ that.userInfo.uid+'&rname='+that.rname
				}) */
			},
			hideModal() {
				this.modalName = null
			},
			// 添加公告
			addNotice() {
				var that = this
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/addOrDeleteNotice",
					data: {
						rid: that.rid,
						uid: that.userInfo.uid,
						notice: that.form_notice,
						method: 1
					},
					success(res) {
						console.log(res)
						that.form_notice = ""
						var e = {}
						e.startDate = null
						e.endDate = null
						e.refresh = true
						that.getRoomDetail(e)
						that.showReadyAddNotice = false
						that.showToast("添加公告成功", "success", "bottom")
					}
				})
			},


			// 获取房间信息
			getRoomDetail(e) {
				uni.showLoading({
					title: '正在加载实验室信息'
				})
				var that = this
				var startDate = e.startDate
				var endDate = e.endDate
				var refresh = e.refresh
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/getRoomDetail",
					data: {
						rid: that.rid
					},
					success(res) {
						console.log(res)
						that.memberInfo = res.data.memberInfo
						that.roomLogInfo = res.data.roomLogInfo
						that.adminInfo = res.data.adminInfo
						if (that.del == 1) {
							that.checkedDel = true
						}

						that.onlineMember = []
						that.offlineMember = []
						that.adminMember = []
						// 分类管理员,在线人员,非在线人员
						for (let i = 0; i < that.memberInfo.length; i++) {
							if (that.memberInfo[i].isAdmin == 1) {
								that.adminMember.push(that.memberInfo[i])
							}
							if (that.memberInfo[i].status == 1) {
								that.onlineMember.push(that.memberInfo[i])
							} else if (that.memberInfo[i].status == 0) {
								that.offlineMember.push(that.memberInfo[i])
							}
						}

						// 日期筛选
						if (startDate != null && endDate != null) {
							console.log("选择日期模式")
							var roomLogInfo_2 = []
							for (let item of that.roomLogInfo) {
								let ldate = moment(item.ldate).format('YYYY-MM-DD')
								if (moment(ldate).isBefore(startDate) == false && moment(ldate).isAfter(endDate) == false) {
									console.log("符合条件" + item)
									roomLogInfo_2.push(item)
								}
							}
							that.roomLogInfo = roomLogInfo_2
							that.roomLogInfo_len2 = that.roomLogInfo.length
							that.startDate = startDate
							that.endDate = endDate
							if (refresh != true) {
								that.showToast("获取从" + startDate + "到" + endDate + "的日志成功", "success", "bottom")
							}

						} else {
							that.roomLogInfo_len = that.roomLogInfo.length
							that.roomLogInfo_len2 = that.roomLogInfo.length
							if (that.roomLogInfo[0] != null) {
								that.startDate = moment(that.roomLogInfo[that.roomLogInfo.length - 1].ldate).format('YYYY-MM-DD')
								that.endDate = moment(that.roomLogInfo[0].ldate).format('YYYY-MM-DD')
							}
							if (refresh != true) {
								that.showToast("实验室" + that.rname + "详细信息查询成功", "success", "bottom")
							}

						}
						console.log("startDate" + startDate)
						console.log("endDate" + endDate)
						uni.hideLoading()
						that.isCale = false
					}
				})
			},
			// 查找所有
			getRoomDetail2() {
				var that = this
				var e = {}
				e.startDate = null
				e.endDate = null
				that.getRoomDetail(e)
			}


		}
	}
</script>

<style>
	.warp {
		display: flex;
		align-items: center;
		justify-content: center;
		height: 100%;
	}

	.rect {
		width: 120px;
		height: 120px;
		background-color: #fff;
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
