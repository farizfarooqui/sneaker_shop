import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneaker_shop/BLOC/HomeBloc/bloc/home_bloc.dart';
import 'package:sneaker_shop/MODEL/Product_model.dart';
import 'package:sneaker_shop/UI/card_screen.dart';
import 'package:sneaker_shop/UI/favourite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is FavPageNavigateActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const FavouriteScreen()));
        }
        if (state is CartPageNavigateActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const CardScreen()));
        }
      },
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeSuccessState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.greenAccent,
                title: const Center(child: Text("Sneaker Store")),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(NavigateToFavListEvent());
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(NavigateToCartListEvent());
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: const Center(
                child: Text(''),
              ),
            );
          default:
            return Container(
              child: const Text('Error 404'),
            );
        }
      },
    );
  }
}
