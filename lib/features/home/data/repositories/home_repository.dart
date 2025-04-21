import 'package:tudy/core/base_service.dart';
import 'package:tudy/core/models/mresponse.dart';
import 'package:tudy/features/home/data/models/task_model.dart';
import 'package:tudy/features/home/data/models/todo_list_request_model.dart';

abstract class HomeRepository {
  Future<MPagingResponse<TaskModel>?> getTasks(int pageIndex);
  Future<bool?> createTaskList(TodoListRequestModel taskModel);
  Future<bool?> updateTaskList(TodoListRequestModel taskModel);
}

class HomeRepositoryImpl extends HomeRepository {
  final BaseService baseService;
  HomeRepositoryImpl({required this.baseService});
  @override
  Future<bool?> createTaskList(TodoListRequestModel taskModel) async {
    final response = await baseService.postData<bool>(
      '/todolist/create',
      taskModel.toJson(),
      fromJson: (dynamic jsonValue) => jsonValue as bool,
    );
    if (response == null) {
      return null;
    }
    return response;
  }

  @override
  Future<MPagingResponse<TaskModel>?> getTasks(int pageIndex) async {
    final response = await baseService.getPagedData<TaskModel>(
      '/todolist/list',
      params: {
        'pageIndex': pageIndex,
      },
      fromJson: (json) => TaskModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<bool?> updateTaskList(TodoListRequestModel taskModel) async {
    final response = await baseService.putData<bool>(
      '/todolist/update',
      taskModel.toJson(),
      fromJson: (dynamic jsonValue) => jsonValue as bool,
    );
    if (response == null) {
      return null;
    }
    return response;
  }
}
