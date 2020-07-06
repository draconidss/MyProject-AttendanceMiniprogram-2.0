<template>
	<view>

		<u-back-top :scroll-top="scrollTop" mode="square" top="0" bottom="20"></u-back-top>
		<!-- 顶部tab栏 -->
		<view style="position: fixed;z-index: 99999;">
			<cu-custom :isBack="true" bgColor="bg-shadeTop text-white">
				<block slot="backText">返回</block>
				<block slot="content">关于&使用手册</block>
			</cu-custom>
		</view>




		<view class="bg-img shadow-blur bg-mask" style="background-image: url('http://mp-images.test.upcdn.net/%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.jpg');height: 420upx;">
			<view class="text-white text-df padding" style="padding-top: 20%;">
				&nbsp;&nbsp;"管理小程序”是一款结合管理实验室出入，记录出入日志，活跃度查看的小程序，在用户出入实验室时，与线下的指纹人脸识别等硬件结合，方便本人和管理员掌控实验室动态，掌控实验室是否开放，成员管理等。</br>这里将会从四个页面(即除了"我的"界面)来介绍小程序的功能（点击图片可放大）
			</view>
		</view>

		<u-notice-bar mode="horizontal" :list="noticeList" close-icon="true" @close="closeNotice" speed="200" v-if="noticeShow"></u-notice-bar>


		<view class="bg-blue">
			<u-subsection :bold="true" :list="tabsList" :current="currentTabs" @change="tabsChange" button-color="#0081ff"
			 active-color="white"></u-subsection>
		</view>


		<!-- 首页 -->
		<block v-if="currentTabs == 0">
			<!-- <view class="cu-list card-menu  shadow"> -->

			<block v-for="(item,index) in homeList" :key="index">
				<u-cell-group>
					<u-cell-item :arrow="true" arrow-direction="down" :title="item.title">
					</u-cell-item>
				</u-cell-group>
				<view class="shadow-blur">
					<navigator>
						<image :src="item.url" mode="aspectFit" class="shadow-blur cu-item" style="width: 100%;" @click="previewImg(homeList,index)"></image>
					</navigator>
				</view>
			</block>
		</block>

		<!-- 日志 -->
		<block v-else-if="currentTabs == 1">
			<block v-for="(item,index) in logList" :key="index">
				<u-cell-group>
					<u-cell-item :arrow="true" arrow-direction="down" :title="item.title">
					</u-cell-item>
				</u-cell-group>
				<view class="shadow-blur">
					<navigator>
						<image :src="item.url" mode="aspectFit" class="shadow-blur cu-item" @click="previewImg(logList,index)"></image>
					</navigator>
				</view>
			</block>
		</block>

		<!-- 仪表盘 -->
		<block v-else-if="currentTabs == 2">
			<!-- 权限说明 -->
			<!-- <view class="cu-list card-menu margin-top shadow-warp " > -->
			<!-- 			<u-cell-group>
				<u-cell-item :arrow="true" arrow-direction="down" title="权限说明">
					<u-icon slot="icon" size="38" name="warning" color="#ff9900" class="padding-right-sm"></u-icon>
				</u-cell-item>
			</u-cell-group> -->

			<view></view>
			<u-collapse style="background-color: white;z-index: 9999;">
				<u-collapse-item title="权限明细" :open="true">
					<u-table>
						<u-tr>
							<u-th>权限/身份</u-th>
							<u-th>超管</u-th>
							<u-th>普通用户</u-th>
						</u-tr>
						<u-tr v-for="(item,index) in dashboardTableList" :key="index">
							<u-th>{{item.tr}}</u-th>
							<u-td>{{item.td1}}</u-td>
							<u-td>{{item.td2}}</u-td>
						</u-tr>
					</u-table>
				</u-collapse-item>
			</u-collapse>


			<view class="padding-top-sm">
				<block v-for="(item,index) in dashboardList" :key="index">
					<u-cell-group>
						<u-cell-item :arrow="true" arrow-direction="down" :title="item.title" :label="item.label" v-if="item.label != null" />
						<u-cell-item :arrow="true" arrow-direction="down" :title="item.title" v-else />
					</u-cell-group>
					<view class="shadow-blur">
						<navigator>
							<image :src="item.url" mode="aspectFit" class="shadow-blur cu-item" @click="previewImg(dashboardList,index)"></image>
						</navigator>
					</view>
				</block>
			</view>
		</block>

		<!-- 活跃度 -->
		<block v-else-if="currentTabs == 3">
			<block v-for="(item,index) in rankList" :key="index">
				<u-cell-group>
					<u-cell-item :arrow="true" arrow-direction="down" :title="item.title">
					</u-cell-item>
				</u-cell-group>
				<view class="shadow-blur" v-if="item.url != null">
					<navigator>
						<image :src="item.url" mode="aspectFit" class="shadow-blur cu-item" @click="previewImg(rankList,index)"></image>
					</navigator>
				</view>
			</block>
		</block>


	</view>
</template>

<script>
	export default {
		data() {
			return {
				wxuserInfo: null,
				userInfo: null,
				currentTabs: 0,
				tabsList: [{
					name: '首页'
				}, {
					name: '日志'
				}, {
					name: '控制台'
				}, {
					name: '活跃度'
				}],

				scrollTop: 0,
				noticeShow: true,

				noticeList: [
					'目前小程序为评审阶段',
					'所以目前版本和正式上线版本有所不同'
				],

				homeList: [{
						title: "1.如果没有实名是无法进入实验室",
						url: "http://mp-images.test.upcdn.net/refe/home/首页提醒实名.jpg"
					}, {
						title: "2.实名后，模拟进入实验室,在首页点击绿色按钮模拟进入实验室",
						url: "http://mp-images.test.upcdn.net/refe/home/进入实验室.jpg"
					},
					{
						title: "3.进入实验室后会发送服务通知",
						url: "http://mp-images.test.upcdn.net/refe/home/订阅消息.jpg"
					},
					{
						title: "4.之后可以查看当前所在实验室的信息，包括出入记录，公告，成员，文件，实验室的概览，在页面最上方可以看到在该实验室的时长",
						url: "http://mp-images.test.upcdn.net/refe/home/出入记录.jpg"
					},
					{
						title: "4.1出入记录",
						url: "http://mp-images.test.upcdn.net/refe/home/出入记录.jpg"
					},
					{
						title: "4.2公告",
						url: "http://mp-images.test.upcdn.net/refe/home/公告.jpg"
					},
					{
						title: "4.3成员",
						url: "http://mp-images.test.upcdn.net/refe/home/成员.jpg"
					},
					{
						title: "4.4文件(TODO)",
						url: "http://mp-images.test.upcdn.net/refe/home/文件.jpg"
					},
					{
						title: "4.5概览",
						url: "http://mp-images.test.upcdn.net/refe/home/概览.jpg"
					}
				],

				// 日志介绍
				logList: [{
						title: "1.日志能显示本人所有进出实验室的日志记录",
						url: "http://mp-images.test.upcdn.net/refe/log/所有日志.jpg"
					},
					{
						title: "2.点击左上角或者日期筛选可以对日期进行筛选",
						url: "http://mp-images.test.upcdn.net/refe/log/日期筛选.jpg"
					},
					{
						title: "3.点击tab栏的我的实验室能查看我去过的实验室",
						url: "http://mp-images.test.upcdn.net/refe/log/去过的实验室.jpg"
					},
					{
						title: "4.点击实验室卡片能查看我在这间实验室的日志",
						url: "http://mp-images.test.upcdn.net/refe/log/在实验室日志.jpg"
					}
				],
				dashboardTableList: [{
					tr: "查看实验室详细",
					td1: "所有实验室",
					td2: "自己管理的"
				}, {
					tr: "关闭/开放实验室",
					td1: "所有实验室",
					td2: "自己管理的"
				}, {
					tr: "添加实验室",
					td1: "√",
					td2: "×"
				}, {
					tr: "添加/删除实验室管理员",
					td1: "√",
					td2: "×"
				}, {
					tr: "添加/删除实验室公告",
					td1: "所有实验室",
					td2: "自己管理的"
				}, {
					tr: "查看用户/用户详细",
					td1: "√",
					td2: "×"
				}, {
					tr: "查看所有用户日志",
					td1: "√",
					td2: "×"
				}],

				// 仪表盘介绍
				dashboardList: [{
						title: "1.查看控制台中实验室总览,包括所有,已开放,未开放,我管理的",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/实验室列表.jpg",
						label: null
					},
					{
						title: "1.2.点击添加实验室可以添加实验室",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/添加实验室.jpg",
						label: "注：只有超管能添加实验室"
					},
					{
						title: "1.3.点击实验室卡片查看实验室详细",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/实验室详细.jpg",
						label: "注：超管能查看所有，普通用户只能查看自己管理的实验室"
					}, {
						title: "1.4.点击概览查看实验室信息,控制实验室是否开放,添加删除管理员",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/提示关闭实验室前.jpg",
						label: "注：只有超管能添加删除实验室管理员"
					}, {
						title: "1.5.控制实验室开放",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/提示关闭实验室前.jpg",
						label: "注：确保没有在实验室人员后才能关闭，否则会提醒"
					}, {
						title: "1.6.添加实验室管理员",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/添加管理员.jpg",
						label: "注：只有超管能添加删除实验室管理员"
					}, {
						title: "1.7.删除管理员",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/删除管理员.jpg",
						label: "注：只有超管能添加删除实验室管理员"
					}, {
						title: "2.查看所有用户索引",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/用户列表.jpg",
						label: "注：只有超管能查看所有用户"
					}, {
						title: "2.1点击查看详情查看用户详情",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/用户基本信息.jpg",
						label: null
					}, {
						title: "2.2查看用户的日志",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/用户的日志.jpg",
						label: null
					}, {
						title: "2.3查看用户去过的实验室",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/用户去过的实验室.jpg",
						label: null
					}, {
						title: "2.4查看用户管理的实验室",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/用户管理的实验室.jpg",
						label: null
					}, {
						title: "3.点击日志查看所有日志并日期筛选查看日志",
						url: "http://mp-images.test.upcdn.net/refe/dashboard/全部日志.jpg",
						label: "注：只有超管能查看所有日志，普通用户只能查看自己管理的实验室的日志"
					},
				],


				// 活跃度介绍
				rankList: [{
						title: "1.查看本周排行榜",
						url: "http://mp-images.test.upcdn.net/refe/rank/周排行榜.jpg"
					},
					{
						title: "2.查看本月排行榜",
						url: "http://mp-images.test.upcdn.net/refe/rank/月排行榜.jpg"
					},
					{
						title: "TODO:历史周排行榜和月排行榜",
						url: null
					}
				]
			}
		},
		onShow() {
			var that = this
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")
			console.log("that.userInfo" + that.userInfo)
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		methods: {
			previewImg(list, index) {
				var imgList = []
				for (let item of list) {
					imgList.push(item.url)
				}

				uni.previewImage({
					current: imgList[index],
					urls: imgList
				})
			},
			closeNotice() {
				this.noticeShow = false
			},
			tabsChange(index) {
				var that = this
				that.currentTabs = index;

			},
		}
	}
</script>

<style>

</style>
