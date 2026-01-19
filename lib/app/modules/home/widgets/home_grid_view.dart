import 'package:errone/app/modules/home/model/all_stream_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class HomeGridView extends StatelessWidget {
  final List<AllStreamModel> streams;
  final Function(AllStreamModel stream) onTap;
  const HomeGridView({super.key,
    required this.streams,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (streams.isEmpty) {
      return const Center(child: Text("No streams found"));
    }
    print("STREAM COUNT => ${streams.length}");

    return GridView.builder(
      key: const PageStorageKey('home_grid'),
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: 14.h),
      itemCount: streams.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: .9,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        mainAxisExtent: 300,

      ),
      itemBuilder: (context, index) {
        final stream = streams[index];
        return GestureDetector(
          onTap: () => onTap(stream),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(14.sp),
              image: DecorationImage(
                // bg image
                image: NetworkImage(stream.thumbnail),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // top button
                  Padding(
                    padding: EdgeInsets.all(2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildSticker(title: stream.status, color: AppColors.pinkColor),
                        buildSticker(icon: Icons.visibility_outlined,title: stream.totalViews.toString(), color: AppColors.primaryColor),
                        buildSticker(icon: Icons.card_giftcard_outlined,title: stream.isPremium == true? "${stream.entryFee}": "free", color: AppColors.yellowColor),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      // Profile section
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Row(
                          children: [
                            // profile Avatar
                            CircleAvatar(
                              radius: 18.r,
                              backgroundColor: AppColors.pinkColor,
                              child: CircleAvatar(
                                radius: 16.r,
                                backgroundImage: NetworkImage(stream.host.profileImage),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${stream.host.firstName} ${stream.host.lastName}",
                                    style: AppTextStyles.regular10,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    stream.title,
                                    style: AppTextStyles.semiBold12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ProgressIndicator + Progress percentage
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withAlpha(170),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: .80,
                                minHeight: 8,
                                backgroundColor: AppColors.pinkColor,
                                color: AppColors.greenAccentColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.greenAccentColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                semanticsLabel: 'Download progress',
                                semanticsValue: '85%',
                              ),
                              SizedBox(height: 4.h),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Legit: ",
                                          style: AppTextStyles.regular10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${100- stream.host.shady!}%",
                                          style: AppTextStyles.regular10,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Shady: ",
                                          style: AppTextStyles.regular10
                                              .copyWith(
                                                color: AppColors.readColor,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${stream.host.shady}%",
                                          style: AppTextStyles.regular10
                                              .copyWith(
                                                color: AppColors.readColor,
                                              ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildSticker({
    IconData? icon, // now optional
    required String title,
    required Color color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min, // shrink to content
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: AppColors.whiteLight),
              const SizedBox(width: 3),
            ],
            Text(
              title,
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.whiteLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
