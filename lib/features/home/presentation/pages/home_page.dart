import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/constants/app_colors.dart';
import '../../../../app/di/injection_container.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../common/widgets/glass_container.dart';
import '../../../common/widgets/nav_bar.dart';
import '../../../common/widgets/pulse_dot.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';
import '../widgets/telemetry_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()..loadTelemetry('DEV-001'),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0F172A),
                Color(0xFF020617),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      );
                    }

                    if (state is HomeErrorState) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline_rounded, color: AppColors.error, size: 48.r),
                            SizedBox(height: 12.h),
                            Text(
                              state.message,
                              style: const TextStyle(color: AppColors.textPrimaryDark),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => context.read<HomeCubit>().loadTelemetry('DEV-001'),
                              child: const Text('Thử lại'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is HomeLoadedState) {
                      final telemetry = state.telemetry;

                      return RefreshIndicator(
                        onRefresh: () => context.read<HomeCubit>().loadTelemetry('DEV-001'),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Bar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Thermo Humi',
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimaryDark,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          PulseDot(
                                            color: telemetry.isOnline ? AppColors.success : AppColors.error,
                                            size: 8,
                                            isLive: telemetry.isOnline,
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            telemetry.isOnline ? 'Đang kết nối Realtime' : 'Mất kết nối',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: AppColors.textSecondaryDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  GlassContainer(
                                    padding: EdgeInsets.all(10.r),
                                    borderRadius: 14.r,
                                    child: Icon(
                                      Icons.notifications_none_rounded,
                                      color: AppColors.textPrimaryDark,
                                      size: 22.r,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 24.h),

                              // Device Header Banner
                              GlassContainer(
                                width: double.infinity,
                                borderRadius: 20.r,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.sensors_rounded,
                                        color: AppColors.primary,
                                        size: 28.r,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            telemetry.deviceName,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimaryDark,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            'ID: ${telemetry.deviceId} • Cập nhật: ${DateFormatter.formatTimeOnly(telemetry.lastUpdated)}',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: AppColors.textSecondaryDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24.h),

                              Text(
                                'Chỉ Số Môi Trường',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimaryDark,
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Telemetry Metrics Grid
                              Row(
                                children: [
                                  Expanded(
                                    child: TelemetryCard(
                                      title: 'Nhiệt độ',
                                      value: telemetry.temperature.toStringAsFixed(1),
                                      unit: '°C',
                                      icon: Icons.device_thermostat_rounded,
                                      accentColor: AppColors.tempWarm,
                                      statusText: 'Lý tưởng',
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: TelemetryCard(
                                      title: 'Độ ẩm',
                                      value: telemetry.humidity.toStringAsFixed(1),
                                      unit: '%',
                                      icon: Icons.water_drop_rounded,
                                      accentColor: AppColors.humidityHigh,
                                      statusText: 'Đạt chuẩn',
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 120.h),
                            ],
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                // Floating Glass Navigation Bar
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CustomNavBar(
                    currentIndex: _navIndex,
                    onTap: (index) {
                      setState(() => _navIndex = index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
