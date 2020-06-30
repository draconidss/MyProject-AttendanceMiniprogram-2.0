<template>
	<view>

		<u-back-top :scroll-top="scrollTop" mode="square" top="0" bottom="20"></u-back-top>
		<!-- 顶部tab栏 -->
		<view style="position: fixed;z-index: 99999;">
			<cu-custom :isBack="true" bgColor="bg-shadeTop text-white">
				<block slot="backText">返回</block>
				<block slot="content">关于</block>
			</cu-custom>
		</view>




		<view class="bg-img shadow-blur bg-mask" style="background-image: url('http://mp-images.test.upcdn.net/%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.jpg');height: 420upx;">
			<view class="text-white text-df padding" style="padding-top: 20%;">
				&nbsp;&nbsp;"实验室出入管理小程序”是结合管理实验室出入，记录出入日志，活跃度查看的一款小程序，在用户出入实验室时，与线下的指纹人脸识别等硬件结合，方便本人和管理员掌控实验室动态，掌控实验室是否开放，成员管理等。</br>这里将会从四个页面(即除了"我的"界面)来介绍小程序的功能
			</view>
		</view>


		<view class="bg-blue">
			<u-subsection :bold="true" :list="tabsList" :current="currentTabs" @change="tabsChange" button-color="#0081ff"
			 active-color="white"></u-subsection>
		</view>


		<block v-if="currentTabs == 0">
			<!-- <view class="cu-list card-menu  shadow"> -->

			<block v-for="(item,index) in homeList" :key="index">
				<u-cell-group>
					<u-cell-item :arrow="false" :title="item.title">
					</u-cell-item>
				</u-cell-group>
				<view class="cu-card  shadow-blur">
					<image :src="item.url" mode="aspectFit" class="shadow-blur cu-item"></image>
				</view>
			</block>






		</block>


	</view>
</template>

<script>
	export default {
		data() {
			return {
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

				homeList: [{
						title: "1.模拟进入实验室,在首页点击绿色按钮模拟进入实验室",
						url: "http://mp-images.test.upcdn.net/refe/%E8%BF%9B%E5%85%A5%E5%AE%9E%E9%AA%8C%E5%AE%A4.jpg"
					},
					{
						title: "2.进入实验室后会发送服务通知",
						url: "http://mp-images.test.upcdn.net/refe/%E8%AE%A2%E9%98%85%E6%B6%88%E6%81%AF.jpg"
					},
					{
						title: "3.之后可以查看当前所在实验室的信息，包括出入记录，公告，成员，文件，实验室的概览，在页面最上方可以看到在该实验室的时长",
						url: "http://mp-images.test.upcdn.net/refe/%E8%AE%A2%E9%98%85%E6%B6%88%E6%81%AF.jpg"
					},
					{
						title: "3.1出入记录",
						url: "http://mp-images.test.upcdn.net/refe/%E5%87%BA%E5%85%A5%E8%AE%B0%E5%BD%95.jpg"
					},
					{
						title: "3.2公告",
						url: "http://mp-images.test.upcdn.net/refe/%E5%85%AC%E5%91%8A.jpg"
					},
					{
						title: "3.3成员",
						url: "http://mp-images.test.upcdn.net/refe/%E6%88%90%E5%91%98.jpg"
					},
					{
						title: "3.4文件",
						url: "http://mp-images.test.upcdn.net/refe/%E6%96%87%E4%BB%B6.jpg"
					},
					{
						title: "3.5概览",
						url: "http://mp-images.test.upcdn.net/refe/%E6%A6%82%E8%A7%88.jpg"
					}
				]
			}
		},
		onPageScroll(e) {
			this.scrollTop = e.scrollTop;
		},
		methods: {
			tabsChange(index) {
				var that = this
				that.currentTabs = index;

			},
		}
	}
</script>

<style>

</style>
