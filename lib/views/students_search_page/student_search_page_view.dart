import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'student_search_page_bloc.dart';
import 'student_search_page_event.dart';
import 'student_search_page_state.dart';

class StudentSearchPageView extends StatefulWidget {
  const StudentSearchPageView({Key? key}) : super(key: key);

  @override
  _StudentSearchPageViewState createState() => _StudentSearchPageViewState();
}

class _StudentSearchPageViewState extends State<StudentSearchPageView> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StudentSearchPageBloc bloc =
        BlocProvider.of<StudentSearchPageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Search"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (value) {
                      bloc.add(OnSearchTextChangedEvent(text: value));
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      bloc.add(OnSearchTextChangedEvent(text: ''));
                    },
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<StudentSearchPageBloc, StudentSearchPageState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.searchResults != current.searchResults ||
                previous.users != current.users,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Expanded(
                child: state.searchResults.isNotEmpty ||
                        controller.text.isNotEmpty
                    ? Card(
                        child: ListView.builder(
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(state
                                          .searchResults[index].profileUrl),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(state.searchResults[index].firstName +
                                        state.searchResults[index].lastName)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Card(
                        child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          state.users[index].profileUrl),
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(state.users[index].firstName +
                                        state.users[index].lastName)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
