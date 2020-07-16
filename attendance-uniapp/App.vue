<script>
	import Vue from 'vue'
	import moment from 'moment'
	/* 	global.showToast = function(title, type, position) {
				this.$refs.uToast.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			}, */
	// 查看是否实名

	Vue.filter('dataFormat', function(time, format) {
		// 格式化时间， 拿到时间
		if (time) {
			if (format == "YMD") {
				return moment(time).format('YYYY-MM-DD')
			}else if (format == "MD") {
				return moment(time).format('MM-DD')
			} else if (format == "YMDHms") {
				return moment(time).format('YYYY-MM-DD HH:mm:ss')
			} else if (format == "Hm") {
				return moment(time).format('HH:mm')
			} else if (format == "E") {
				return moment(time).locale('zh-cn').format('E')
			} else if (format == "duration") {
				var h = Math.floor(time / 1000 / 60 / 60);
				var m = Math.floor(time / 1000 / 60 % 60);
				var s = Math.floor(time / 1000 % 60);
				return h + "时" + m + "分"
			} else if (format == "length") {
				return time.length
			} else {
				return moment(time).format('YYYY-MM-DD HH:mm:ss')
			}
		}

	});

	//时间格式化
	Vue.filter('duration', function(time) {
		let now = moment(); //当下时间
		// let m2=moment('2019-12-18 10:10:00');
		let last = moment(time);
		let duration = moment.duration(now - last, 'ms'); //做差
		let days = duration.get('days');
		let hours = duration.get('hours');
		let mins = duration.get('minutes');
		let ss = duration.get('seconds');
		//  输出结果为   01天08时09分40秒
		if (days > 0) {
			return days + '天前'
		} else if (hours > 0) {
			return hours + '小时前'
		} else {
			return mins + '分钟前'
		}

	});

	global.getUserInfo = function() {
		var wxuserInfo = uni.getStorageSync("wxuserInfo")
		if (wxuserInfo) {
			uni.request({
				url: "https://api.attendance.lifeisgg.online/MP/public/login",
				data: {
					openid: wxuserInfo.openid,
					nickName: wxuserInfo.nickName,
					avatarUrl: wxuserInfo.avatarUrl,
					isLogin: false
				},
				success(res) {
					console.log(res)
					uni.setStorageSync("userInfo", res.data.userInfo)
					return null
				}
			})
		} else {
			uni.setStorageSync("userInfo", null)
			return null
		}


	};

	// 封装请求
	global.request = function(e) {
		var e = e
		var result = {}
		uni.request({
			url: e.url,
			data: e.data,
			success(res) {
				uni.setStorageSync("request_result", res)
			}
		})
		result = uni.getStorageSync("request_result")
		console.log(result)
		return result

	};

	//地图位置
	import amap from "libs/amap-wx.js";
	global.loadMap = function() {
		try {
			var mapInfo = null
			mapInfo = uni.getStorageSync('mapInfo');

		} catch (e) {
			//TODO handle the exception
		}
		if (mapInfo == '' || mapInfo == null) {
			console.log("mapinfo为空")
			var amapPlugin = new amap.AMapWX({
				key: '65743e0123cff82cc013c8eb34d5eaa2' //该key 是在高德中申请的微信小程序key
			});
			amapPlugin.getRegeo({
				type: 'gcj02', //map 组件使用的经纬度是国测局坐标， type 为 gcj02
				success: function(res) {
					console.log('map 组件使用的经纬度是国测局坐标， type 为 gcj02')
					console.log(res[0])
					var mapInfo = res[0]
					console.log('mapInfo', mapInfo)
					uni.setStorageSync('mapInfo', mapInfo)

					return mapInfo;
				},
				fail: (res) => {
					console.log(JSON.stringify(res));
				}
			});
		} else {

			return mapInfo;
		}

	};
	export default {
		onLaunch: function() {
			if (!wx.cloud) {
				console.error('请使用 2.2.3 或以上的基础库以使用云能力')
			} else {
				wx.cloud.init({
					// env 参数说明：
					//   env 参数决定接下来小程序发起的云开发调用（wx.cloud.xxx）会默认请求到哪个云环境的资源
					//   此处请填入环境 ID, 环境 ID 可打开云控制台查看
					//   如不填则使用默认环境（第一个创建的环境）
					env: 'attendency-mi1aj',
					traceUser: true,
				})
			}
			uni.getSystemInfo({
				success: function(e) {
					// #ifndef MP
					Vue.prototype.StatusBar = e.statusBarHeight;
					if (e.platform == 'android') {
						Vue.prototype.CustomBar = e.statusBarHeight + 50;
					} else {
						Vue.prototype.CustomBar = e.statusBarHeight + 45;
					};
					// #endif

					// #ifdef MP-WEIXIN
					Vue.prototype.StatusBar = e.statusBarHeight;
					let custom = wx.getMenuButtonBoundingClientRect();
					Vue.prototype.Custom = custom;
					Vue.prototype.CustomBar = custom.bottom + custom.top - e.statusBarHeight;
					// #endif		

					// #ifdef MP-ALIPAY
					Vue.prototype.StatusBar = e.statusBarHeight;
					Vue.prototype.CustomBar = e.statusBarHeight + e.titleBarHeight;
					// #endif
				}
			})

			Vue.prototype.ColorList = [{
					title: '嫣红',
					name: 'red',
					color: '#e54d42'
				},
				{
					title: '桔橙',
					name: 'orange',
					color: '#f37b1d'
				},
				{
					title: '明黄',
					name: 'yellow',
					color: '#fbbd08'
				},
				{
					title: '橄榄',
					name: 'olive',
					color: '#8dc63f'
				},
				{
					title: '森绿',
					name: 'green',
					color: '#39b54a'
				},
				{
					title: '天青',
					name: 'cyan',
					color: '#1cbbb4'
				},
				{
					title: '海蓝',
					name: 'blue',
					color: '#0081ff'
				},
				{
					title: '姹紫',
					name: 'purple',
					color: '#6739b6'
				},
				{
					title: '木槿',
					name: 'mauve',
					color: '#9c26b0'
				},
				{
					title: '桃粉',
					name: 'pink',
					color: '#e03997'
				},
				{
					title: '棕褐',
					name: 'brown',
					color: '#a5673f'
				},
				{
					title: '玄灰',
					name: 'grey',
					color: '#8799a3'
				},
				{
					title: '草灰',
					name: 'gray',
					color: '#aaaaaa'
				},
				{
					title: '墨黑',
					name: 'black',
					color: '#333333'
				},
				{
					title: '雅白',
					name: 'white',
					color: '#ffffff'
				},
			]

		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style lang="scss">
	@import "uview-ui/index.scss";
	@import "colorui/main.css";
	@import "colorui/icon.css";
	/*每个页面公共css */

	// u-cell点击效果
	.cell-hover-class {
		background-color: rgb(235, 237, 238);
	}

	/* 或者单是设置透明度 */
	.cell-hover-class {
		opacity: 0.5;
	}
</style>
