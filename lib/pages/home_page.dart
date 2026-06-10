import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/countryC.dart';
import '../controllers/userC.dart';
import '../themes/colors.dart';
import '../widgets/country_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userC = Get.find<UserC>();
  final countryC = Get.find<CountryC>();

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    userC.loadUser();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        countryC.loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void showLogoutDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      title: 'Logout',
      desc: 'Apakah kamu yakin ingin keluar dari aplikasi?',
      btnCancelText: 'Batal',
      btnOkText: 'Logout',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        userC.logout();
      },
      btnOkColor: AppColors.danger,
      btnCancelColor: AppColors.textGrey,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Countries',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Halo, ${userC.username.value}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: showLogoutDialog,
              icon: const Icon(Icons.logout_rounded, color: AppColors.danger),
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: searchController,
              onChanged: countryC.applySearch,
              decoration: InputDecoration(
                hintText: 'Cari negara atau ibukota...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Obx(
                      () => countryC.searchKeyword.value.isEmpty
                      ? const SizedBox()
                      : IconButton(
                    onPressed: () {
                      searchController.clear();
                      countryC.applySearch('');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
                filled: true,
                fillColor: const Color(0xFFF6F7FB),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (countryC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (countryC.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.wifi_off_rounded,
                          size: 56,
                          color: AppColors.textGrey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          countryC.errorMessage.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: countryC.getCountries,
                          child: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (countryC.countries.isEmpty) {
                return const Center(
                  child: Text(
                    'Negara tidak ditemukan',
                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: countryC.refreshCountries,
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: countryC.countries.length + 1,
                  itemBuilder: (context, index) {
                    if (index < countryC.countries.length) {
                      final country = countryC.countries[index];
                      return CountryCard(country: country);
                    }

                    return Obx(() {
                      if (countryC.isLoadMore.value) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (!countryC.hasMore) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'Semua data sudah ditampilkan',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }

                      return const SizedBox(height: 24);
                    });
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}