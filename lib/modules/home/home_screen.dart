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
import 'package:notewise/modules/widgets/custom_button.dart';

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
        user: widget.user,
        onUpdate: _onUpdate,
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
                        _onUpdate();
                      },
                      child: ListView.builder(
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(
                                Utils.adaptiveHeight(context, 2)),
                            child: NoteWidget(
                              note: state.notes[index],
                              user: state.user,
                              onUpdate: _onUpdate,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No notes yet',
            style: TextStyle(
              fontSize: Utils.adaptiveWidth(context, 7),
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(text: 'Update', onTap: _onUpdate),
        ],
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

  void _onUpdate() {
    _homeBloc.load(widget.user);
  }
}
