<template>
	<view>
		<!-- 顶部栏 -->
		<web-view :webview-styles="webviewStyles" src="https://wiki.lifeisgg.online/archives/%E8%AE%A4%E8%AF%86SpringCloud"></web-view>

	</view>
</template>

<script>
	export default {
		data() {
			return {
				rid: null,
				uid: null,
				rname: null,
				form_notice: ''
			}
		},
		onLoad(option) {

			
			
			console.log(option)
			that.rid = parseInt(option.rid)
			that.uid = parseInt(option.uid)
			that.rname = option.rname
		},
		methods: {
			addNotice() {
				var that = this
				uni.request({
					url: "http://47.100.59.153:8885/MP/admin/addOrDeleteNotice",
					data: {
						rid: that.rid,
						uid: that.uid,
						notice: that.form_notice,
						method: 1
					},
					success(res) {
						console.log(res)						
						that.showToast("添加公告成功", "success", "bottom")
						uni.navigateBack({
							
						})
					}
				})
			}
		}
	}
</script>

<style>

</style>
