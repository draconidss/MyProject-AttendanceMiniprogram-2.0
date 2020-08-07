<template>
	<view>
		<!-- toast提示 -->
		<u-toast ref="uToast" />

		<!-- 当wxuserInfo不存在时 -->
		<view class="cu-modal show" v-if="!wxuserInfo">
			<view class="cu-dialog">
				<u-button type="success" :loading="getWxUserInfoLoading" open-type="getUserInfo" @getuserinfo="getWxUserInfo"
				 :ripple="true">
					<u-icon name="weixin-fill" size="40" style="margin-right:10rpx ;"></u-icon>微信一键登录
				</u-button>
			</view>
		</view>


		<!-- 当wxuserInfo存在时 -->
		<view v-else>
			<!-- profile上方 -->
			<view class="bg-img bg-mask flex align-end shadow-blur" style="background-image: url('http://mp-images.test.upcdn.net/profile.jpg');height: 400upx;">
				<view class="bg-shadeCenter padding  flex  align-start">
					<!-- #ifdef MP-WEIXIN -->
					<!-- {{userInfo.avatarUrl}} -->
					<view class="cu-avatar xl radius shadow" :style="{backgroundImage:'url('+wxuserInfo.avatarUrl+')'}">
						<view class="cu-tag badge" :class="wxuserInfo.gender==1?'cuIcon-male bg-blue':'cuIcon-female bg-pink'">
						</view>
					</view>
					<!-- #endif -->

					<view class="grid col-1">
						<view class=" padding-left-sm radius text-bold text-white text-xl">{{wxuserInfo.nickName}}</view>
						<view class="cu-capsule radius padding-sm padding-top-lg">
							<view class="cu-tag bg-blue xl">
								<text class="cuIcon-people "></text>
							</view>
							<view class="cu-tag line-white xl ">
								{{userInfo.level == 1?'超级管理员':'普通用户'}}
							</view>
						</view>
					</view>
				</view>
			</view>



			<!-- 小菜单1 -->
			<view class="cu-list menu card-menu margin-top sm-border shadow-warp">

				<!-- 实名认证 -->
				<view class="cu-item arrow padding " @tap="showModal" data-target="boundModal">
					<view class="content ">
						<text class="cuIcon-people text-cyan "></text>
						<text class="text-grey  ">实名认证</text>
					</view>
					<view class="action">
						<view class="cu-tag round bg-blue" v-if="userInfo">已认证</view>
						<view class="cu-tag round bg-red" v-else>点击认证</view>
					</view>
				</view>

				<!-- 接收消息 -->
				<view class="cu-item">
					<view class="content">
						<text class="cuIcon-notice text-green"></text>
						<text class="text-grey">接收消息</text>
					</view>
					<view class="action">
						<switch class='green radius' @click="wakeUpMsg" @change="SwitchSendMsg" :class="wxuserInfo.sendMsg?'checked':''"
						 :checked="wxuserInfo.sendMsg?true:false"></switch>
					</view>
				</view>

				<!-- 人工服务 -->
				<view class="cu-item arrow">
					<button class="cu-btn content" open-type="contact">
						<text class="cuIcon-service text-orange text-xl"></text>
						<text class="text-gray">联系我们</text>
					</button>
				</view>
			</view>

			<!-- 实名绑定 -->
			<view class="cu-modal" :class="modalName=='boundModal'?'show':''">
				<!-- 未绑定 -->
				<view class="cu-dialog"   v-if="!userInfo">
					<u-toast ref="uToast_realName" />
					<!-- 提示框 -->
					<view class="cu-bar bg-white justify-end">
						<view class="content">实名注册</view>
						<view class="action" @tap="hideModal">
							<text class="cuIcon-roundclose text-red text-sl"></text>
						</view>
					</view>

					<form>
						<u-cell-group>
							<!-- <u-keyboard ref="uKeyboard" mask="false" mode="number" v-model="keyboard"></u-keyboard> -->
							<u-field v-model="form_realName" label="姓名" icon="account" icon-color="green" placeholder="真实姓名" name="form_realName">
							</u-field>
							<!-- <u-field v-model="form_password" label="密码" icon="lock" icon-color="red" placeholder="填写注册密码" name="form_realName">
							</u-field> -->
							<u-field v-model="form_phone" label="手机号" icon="phone" icon-color="blue" placeholder="国内请填写11位手机号" @blur="checkPhone"
							 :error-message="phoneErrorMsg" name="form_phone">
							</u-field>

							<u-field v-model="form_code" label="验证码" icon="attach" icon-color="orange" placeholder="请填写六位验证码" name="code">
								<u-button size="mini" slot="right" type="primary" @click="getCode">{{codeText}}</u-button>
							</u-field>
							<u-verification-code ref="uCode" @change="codeChange"></u-verification-code>

							<u-button @click="realNameSubmit" type="success" plain :ripple="true" style="padding-top: 5rpx;">立即认证</u-button>
						</u-cell-group>


					</form>
				</view>

				<!-- 实名认证已绑定 -->
				<view class="cu-dialog "  v-else>
					<view class="cu-bar bg-white justify-end">
						<view class="content">实名认证</view>
						<view class="action" @tap="hideModal">
							<text class="cuIcon-roundclose text-red text-sl"></text>
						</view>
					</view>
					<u-cell-group>
						<u-cell-item :arrow="false" :center="true" title="uid" :value="userInfo.uid">
							<view slot="icon" class="cuIcon-title padding-right-sm text-green"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="姓名" :value="userInfo.realName">
							<view slot="icon" class="cuIcon-profile padding-right-sm text-blue"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="手机" :value="userInfo.phone">
							<view slot="icon" class="cuIcon-phone padding-right-sm text-red"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="注册时间" :value="wxuserInfo.regDate | dataFormat()">
							<view slot="icon" class="cuIcon-calendar padding-right-sm text-cyan"></view>
						</u-cell-item>

						<u-cell-item :arrow="false" :center="true" title="上次登录" :value=" wxuserInfo.lastLoginDate | dataFormat()">
							<view slot="icon" class="cuIcon-calendar padding-right-sm text-blue"></view>
						</u-cell-item>

						<u-cell-item :arrow="false" :center="true" title="权限" value="超级管理员" v-if="userInfo.level == 1">
							<view slot="icon" class="cuIcon-flashbuyfill padding-right-sm text-orange"></view>
						</u-cell-item>
						<u-cell-item :arrow="false" :center="true" title="权限" value="普通用户" v-else>
							<view slot="icon" class="cuIcon-flashbuyfill padding-right-sm text-orange"></view>
						</u-cell-item>
					</u-cell-group>

				</view>

			</view>






			<!-- 小菜单2 -->
			<view class="cu-list menu card-menu margin-top sm-border shadow-warp">

				<view class="cu-item arrow" @tap="exitLogin">
					<view class="content">
						<text class="cuIcon-exit text-mauve text-xl"></text>
						<text class="text-gray">退出登录</text>
					</view>
				</view>

				<view class="cu-item arrow" @tap="clearStorage">
					<view class="content">
						<text class="cuIcon-delete text-yellow text-xl "></text>
						<text class="text-gray">清空缓存</text>
					</view>
					<view class="action">
						<view class="cu-tag round bg-blue">{{storageInfo.currentSize}}kb</view>
					</view>
				</view>
			</view>

<!-- 			<view class="cu-list card-menu  shadow">
				<u-cell-group>
					<u-cell-item :arrow="true" title="一键成为超级管理员(测试用)" label="点击前请先实名注册" @tap="beAdmin">
						<u-icon slot="icon" size="60" name="warning" color="#ff9900"></u-icon>
					</u-cell-item>
				</u-cell-group>

			</view> -->


			<view class="cu-card ">
				<view class="cu-item shadow-blur bg-img bg-mask flex align-center" style="background-image: url(http://mp-images.test.upcdn.net/%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C.jpg);height: 150upx;">
					<navigator url="reference" class="shadow-blur">
						<view class="padding-left-xl padding-top-lg text-white">
							<view class=" text-xxl text-bold">
								关于&使用手册
							</view>
						</view>
					</navigator>
				</view>
			</view>



			<!-- 				<navigator  class="shadow-blur">
					<view class="cu-card " @tap="beAdmin">					
						<view class="cu-item shadow-blur bg-img bg-mask flex align-center" style="background-image: url(http://mp-images.test.upcdn.net/admin.jpg);height: 150upx;">
							<view class="flex solid-bottom justify-between">
								<view class="padding-left-xl padding-top-lg text-white">
									<view class=" text-xl text-bold padding-bottom-lg">
										一键成为超级管理员(测试用)
									</view>
								</view>
							</view>
						</view>					
					</view>
					</navigator> -->




		</view>

	</view>
	</view>
	</view>
</template>

<script>
	import moment from 'moment'
	export default {
		data() {
			return {
				regDate: null,
				show: true,
				modalName: null,
				getWxUserInfoLoading: false,
				// 微信用户信息和实名用户信息
				wxuserInfo: null,
				userInfo: null,
				// 缓存信息
				storageInfo: null,
				// request请求的结果
				request_result: null,
				// 实名注册的数据
				codeText: null,
				codeSend: null,
				code: null,
				phoneErrorMsg: "",
				form_code: null,
				form_password: null,
				form_phone: null,
				form_realName: null
			}
		},
		onShow() {
			var that = this
			console.log("onShow()")
			that.wxuserInfo = uni.getStorageSync("wxuserInfo")
			global.getUserInfo()
			that.userInfo = uni.getStorageSync("userInfo")
			console.log("that.userInfo" + that.userInfo)


			// 获取缓存信息
			that.getStorageInformation()
		},
		onShareAppMessage: function() {
			return {
				title: "我的",
				path: '/pages/profile/profile'
			}

		},

		methods: {
			// 打开用户手册
			openRefe() {

				uni.openDocument({
					filePath: 'https://example.com/somefile.pdf',
					success: function(res) {
						console.log('打开文档成功');
					}
				});

			},
			// 测试用:成为超级管理员
			beAdmin() {
				var that = this
				if (that.userInfo == null) {
					that.showToast("请先实名注册", "warning", "bottom")
					return false
				}
				var that = this
				uni.showModal({
					title: "这是测试用，确定成为超级管理员吗",
					success: function(res) {
						if (res.confirm) {
							uni.request({
								url: "https://api.attendance.lifeisgg.online/MP/profile/test/beAdmin",
								data: {
									uid: that.userInfo.uid
								},
								success(res) {

									that.userInfo.level = 1
									uni.setStorageSync("userInfo", that.userInfo)
									that.showToast("成为超级管理员成功", "success", "bottom")
								}
							})
						}
					},
				})

			},
			// 封装请求
			request(e) {
				var e = e
				var that = this
				uni.request({
					url: e.url,
					data: e.data,
					success(res) {
						that.request_result = res.data
					}
				})
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


			// modal隐藏唤醒
			showModal(e) {
				this.modalName = e.currentTarget.dataset.target
			},
			hideModal(e) {
				this.modalName = null
			},



			/* 登录退出方法*/
			// 点击登录按钮登录登录
			getWxUserInfo: function(res) {
				var that = this;
				if (!res.detail.iv) {
					that.showToast('求求您授权吧', 'error', 'bottom')
					return false;
				}
				that.getWxUserInfoloading = true
				console.log(res)
				that.wxuserInfo = res.detail.userInfo
				that.switchMsg = true
				that.wxuserInfo.switchMsg = true

				// 调用云函数获取openid
				wx.cloud.callFunction({
					name: 'login',
					data: {},
					success: res => {
						console.log(res)
						console.log('[云函数] [login] user openid: ', res.result.openid)
						that.wxuserInfo.openid = res.result.openid

						// 按钮登录请求后台返回实名信息

						console.log("请求前的wxuserinfo" + that.wxuserInfo.openid)
						uni.request({
							url: "https://api.attendance.lifeisgg.online/MP/public/login",
							data: {
								nickName: that.wxuserInfo.nickName,
								openid: that.wxuserInfo.openid,
								avatarUrl: that.wxuserInfo.avatarUrl,
								isLogin: true
							},
							success(res) {
								console.log(res)
								that.wxuserInfo.uid = res.data.wxuserInfo.uid
								that.wxuserInfo.regDate = res.data.wxuserInfo.regDate
								that.wxuserInfo.lastLoginDate = res.data.wxuserInfo.lastLoginDate
								that.userInfo = res.data.userInfo

								uni.setStorageSync("wxuserInfo", that.wxuserInfo)
								uni.setStorageSync("userInfo", that.userInfo)
								that.getWxUserInfoloading = false
								that.showToast('微信登录成功', 'success', 'bottom')
								that.modalName = 'boundModal'

							}

						})

					},
					fail: err => {
						console.error('[云函数] [login] 调用失败', err)
						that.showToast('请检查网络', 'warning', 'bottom')
						return false
					}
				})


			},
			// 退出登录
			exitLogin() {
				var that = this;
				uni.showModal({
					title: "确定要退出吗",
					success: function(res) {
						if (res.confirm) {
							that.showToast('退出成功', 'success', 'bottom')
							that.wxuserInfo = null;
							that.userInfo = null;
							uni.setStorageSync("wxuserInfo", null);
							uni.setStorageSync("userInfo", null);
						}
					}
				})
			},

			// 获取缓存
			getStorageInformation() {
				var that = this
				uni.getStorageInfo({
					success: function(res) {
						that.storageInfo = res
						console.log("keys:" + res.keys);
						console.log("currentSize:" + res.currentSize);
						console.log("limitSize:" + res.limitSize);
					}
				});
			},
			// 清空缓存
			clearStorage() {
				var that = this
				uni.showModal({
					title: "清除缓存将会清除登录状态",
					success: function(res) {
						if (res.confirm) {
							that.wxuserInfo = null;
							uni.clearStorage()
							that.getWxUserInfoLoading = false
						}
					}
				})
			},

			/* 实名注册方法 */
			// 提示
			showToast_realName(title, type, position) {
				this.$refs.uToast_realName.show({
					title: title,
					type: type,
					position: position,
					duration: 2500
				})
			},
			checkPhone() {
				var that = this
				console.log("手机输入失去焦点")
				uni.request({
					url: "https://api.attendance.lifeisgg.online/MP/profile/checkExist",
					data: {
						phone: that.form_phone
					},
					success(res) {
						console.log(res)
						if (res.data.phone == null) {
							that.phoneErrorMsg = "电话号码已绑定"
							that.showToast_realName("电话号码已存在", "warning", "bottom")
							return false
						} else {
							that.phoneErrorMsg = ""
							that.showToast_realName("电话号码可用", "success", "bottom")
							return true
						}
						
					}
				})
			},
			// 验证码监听
			codeChange(text) {
				this.codeText = text;
			},
			getCode() {
				var that = this
				console.log("获取验证码")
				if (that.$refs.uCode.canGetCode) {
					// 模拟向后端请求验证码
					uni.showLoading({
						title: '正在获取验证码'
					})
					let phone = that.form_phone
					console.log("电话" + phone)
					// 向后端请求验证码
					var codeChars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
					var code = ""
					for (var i = 0; i < 6; i++) {
						var id = Math.ceil(Math.random() * 9);
						code += codeChars[id];
					}
					that.codeSend = +code
					console.log("验证码为" + that.codeSend)
					wx.cloud.callFunction({
						name: 'sendSms',
						data: {
							'phone': phone,
							'code': that.codeSend
						},
						success: res => {
							console.log(res)
							setTimeout(() => {
								uni.hideLoading()
								that.showToast_realName('验证码已发送', 'success', 'bottom')
								// 通知验证码组件内部开始倒计时
								this.$refs.uCode.start();
							}, 1000);
						},
						fail: err => {
							console.error('[云函数] [login] 调用失败', err)
						}
					})
				} else {
					that.showToast_realName('请倒计时结束再重新发送', 'error', 'bottom')
				}
			},

			realNameSubmit() {
				var that = this
				if(that.form_code == null || that.form_realName == null || that.form_phone == null){
					that.showToast("请填写完整信息","error","bottom")
					return false
				}else{
					if(that.checkPhone() == false){
						return false
					}else{
						if(that.form_code != that.codeSend){
							that.showToast("您输入的验证码不正确","error","bottom")
							return false
						}
					}
					
				}
				uni.request({
					url: "https://api.attendance.lifeisgg.online/MP/profile/realProfile",
					data: {
						openid: that.wxuserInfo.openid,
						phone: that.form_phone,
						realName: that.form_realName,
					},
					success(res) {
						console.log(res)
						that.userInfo = res.data.userInfo
						uni.setStorageSync("userInfo", that.userInfo)
						that.hideModal()
						that.showToast("实名认证成功", "success", "bottom")
					}
				})
			},

			// 服务提醒通知开关
			// 按钮改变时
			SwitchSendMsg(e) {
				var that = this
				var switchMsg = e.detail.value
				that.wxuserInfo.switchMsg = switchMsg
				console.log("that.wxuserInfo.switchMsg=" + that.wxuserInfo.switchMsg)
				if (this.wxuserInfo.switchMsg == true) {

				}
			},
			wakeUpMsg() {
				var that = this
				if (that.wxuserInfo.switchMsg == true) {
					wx.requestSubscribeMessage({
						tmplIds: [
							'jxm2u-gMXptrgJBsHOThe9-1L4Vw2dghG7J05FLEEKk',
						],
						success(res) {
							console.log(res)
						},
						fail(err) {
							console.log(err);
						}
					})
				}
			},
			// 请求发送打卡通知
			sendMsg: function(e) {
				wx.requestSubscribeMessage({
					tmplIds: [
						'il9K_JqyWPEIKbIHaSMHMvRM3BYAMt_UC6gCVERpXjU',
					],
					success(res) {
						console.log(res)
						that.showToast("打卡订阅消息开启成功", "success", "bottom")
					},
					fail(err) {
						console.log(err);
					}
				})
			},
		}
	}
</script>

<style>

</style>
