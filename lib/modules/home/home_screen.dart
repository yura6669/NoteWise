import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notewise/core/di/locator.dart';
import 'package:notewise/core/models/user.dart';
import 'package:notewise/modules/home/bloc/home_bloc.dart';
import 'package:notewise/modules/home/widgets/home_app_bar.dart';
import 'package:notewise/modules/home/widgets/no_internet_widget.dart';
import 'package:notewise/modules/home/widgets/note_widget.dart';
import 'package:notewise/modules/resorses/app_colors.dart';
import 'package:notewise/modules/resorses/utils.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  static const routeName = 'home';
  const HomeScreen({
    required this.user,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = locator.get();
    _homeBloc.load(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _buildLoader();
          } else if (state.isNoInternet) {
            return NoInternetWidget(
              onTap: () => _homeBloc.load(widget.user),
            );
          } else if (state.isLoaded) {
            return _buildContent(state);
          } else if (state.isError) {
            return _buildError(state.errorMessage);
          } else {
            return _buildError('Unknown error');
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildContent(HomeState state) {
    return Scaffold(
      appBar: homeAppBar(
        context: context,
        greeting: state.greeting,
        name: widget.user.name,
      ),
      body: state.notes.isEmpty
          ? _buildEmpty()
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        _homeBloc.load(widget.user);
                      },
                      child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                                Utils.adaptiveHeight(context, 2)),
                            child: NoteWidget(
                              state.notes[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'No notes yet',
        style: TextStyle(
          fontSize: Utils.adaptiveWidth(context, 7),
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          color: AppColors.textColor,
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Material(
      child: Center(
        child: Text(
          'Something went wrong: $message',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Utils.adaptiveWidth(context, 7),
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: AppColors.textColor,
          ),
        ),
      ),
    );
  }
}
