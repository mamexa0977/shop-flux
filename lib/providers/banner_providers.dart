import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/datasources/remote/public_api.dart';
import '../data/models/banner.dart';
import '../core/network/dio_client.dart';

final bannerApiProvider = Provider<PublicApi>((ref) {
  final dio = ref.watch(dioProvider);
  return PublicApi(dio);
});

final bannersProvider = FutureProvider<List<Banner>>((ref) async {
  final api = ref.read(bannerApiProvider);
  final response = await api.getBanners();
  print('Banner API response###############################################################################################################################: $response');
  final data = response['data']['banners'] as List;
  return data.map((e) => Banner.fromJson(e)).toList();
});