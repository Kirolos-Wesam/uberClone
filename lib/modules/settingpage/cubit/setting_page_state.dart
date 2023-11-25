part of 'setting_page_cubit.dart';

@immutable
sealed class SettingPageState {}

final class SettingPageInitial extends SettingPageState {}

final class ProfileImagePickedSuccessState extends SettingPageState {}

final class ProfileImagePickedErrorState extends SettingPageState {}

final class UpdateUserLoadingState extends SettingPageState {}

final class UpdateUserSuccessState extends SettingPageState {}

final class UpdateUserErrorState extends SettingPageState {}

final class UpdatingProfileImageSuccessState extends SettingPageState {}

final class UpdatingProfileImageErrorState extends SettingPageState {}




