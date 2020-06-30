<template>
	<view>
		
		<!-- 		<scroll-view style="background-color: white;" scroll-y class="DrawerPage" :class="modalName=='showDrawer'?'show':''"
				 :scroll-top="scrollTop" @scroll="scroll"> -->
				<!-- <scroll-view style="background-color: white;" scroll-y class="DrawerPage" :class="modalName=='showDrawer'?'show':''"> -->
		
					<!-- 顶栏 -->
		<!-- 			<cu-custom bgColor="bg-gradual-blue" icon="messagefill">
						<block slot="content">仪表盘</block>
						<block slot="left">
							<view class="cu-avatar radius " :style="{backgroundImage:'url('+wxuserInfo.avatarUrl+')'}" />
							<text class="text-bold text-xl padding-left-sm">{{userInfo.realName}}</text>
						</block>
		
					</cu-custom> -->
		
		
		
		
		
		
		
		
		<view class="cu-list grid col-2 shadow-warp">
			<view class="cu-item">
				<u-circle-progress active-color="#2979ff" :percent="100" width="180">
						<view class="u-progress-content">
							<text class='u-progress-info'>已开放</text>
						</view>
					</u-circle-progress>
			</view>
		
				<view class="cu-list grid col-2 shadow-warp">
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-sm text-green">
								开放
							</view>
							<view class="margin-top-xs text-grey text-sm">状态</view>
						</view>
					</view>
					
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-sm text-green">
								开放
							</view>
							<view class="margin-top-xs text-grey text-sm">状态</view>
						</view>
					</view>
					<view class="cu-item">
						<view class="flex flex-sub flex-direction solid-right">
							<view class="text-sm text-green">
								开放
							</view>
							<view class="margin-top-xs text-grey text-sm">状态</view>
						</view>
					</view>
					<view class="cu-item">									
							<view class="text-sm text-green">
								开放
							</view>
							<view class="margin-top-xs text-grey text-sm">状态</view>									
					</view>
				</view>
				
				
				<!-- <u-grid :col="2">
					
					<u-grid-item v-for="(item,index) in roomList" v-if="currentLabTabs == 0">
						<view class="cu-card " @click="showModal" data-modal="showMsg">
							<view class="cu-item shadow-blur bg-img bg-mask " :style="{backgroundImage:'url(https://photosbed.lifeisgg.online/小程序图片/lab'+index%4+'.jpg)'}"
							 style="height: 180upx;">
								<view class="flex solid-bottom justify-center">
									<view class="padding-sm text-white">
										<view class=" text-xl text-bold">
											{{item.rname}}
										</view>
										<view class="padding-top-sm text-lg">
											<u-button type="primary" :ripple="true" size="mini">5人在线</u-button>
				
										</view>
									</view>
									<u-tag text="开放" type="success" mode="dark" v-if="item.del == 1" />
									<u-tag text="关闭" type="error" mode="dark" v-else/>
								</view>
							</view>
						</view>
					</u-grid-item>
					
					<u-grid-item v-for="(item,index) in myAdminRoomList" v-if="currentLabTabs == 1">
						<view class="cu-card " @click="showModal" data-modal="showMsg" >
							<view class="cu-item shadow-blur bg-img bg-mask " :style="{backgroundImage:'url(https://photosbed.lifeisgg.online/小程序图片/lab'+index%4+'.jpg)'}"
							 style="height: 180upx;">
								<view class="flex solid-bottom justify-center">
									<view class="padding-xs text-white">
										<view class=" text-lg text-bold">
											{{item.room.rname}}
										</view>
										<view class="padding-top-sm text-lg">
											<u-button type="primary" :ripple="true" size="mini">5人在线</u-button>
					
										</view>
									</view>
									<u-tag text="开放" type="success" mode="dark" v-if="item.room.del == 1" />
									<u-tag text="关闭" type="error" mode="dark" v-else/>
								</view>
							</view>
						</view>
					</u-grid-item>
					
					
				</u-grid> -->
				
				
				
			
		
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
			}
		},
		methods: {
			
		}
	}
</script>

<style>

</style>
