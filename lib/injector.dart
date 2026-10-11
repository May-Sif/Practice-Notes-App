import 'package:get_it/get_it.dart';
import 'package:note/note.dart';
// import 'package:core_services/core_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'note/presentation/bloc/note_bloc.dart';

final getIt = GetIt.instance;

void setupInjector() {
  final supabase = Supabase.instance.client;

  getIt.registerLazySingleton<NoteSupabaseDatasource>(
    () => NoteSupabaseDatasource(supabase),
  );
  getIt.registerLazySingleton<NoteRepositoryImpl>(
    () => NoteRepositoryImpl(getIt<NoteSupabaseDatasource>()),
  );
  getIt.registerLazySingleton<GetNotes>(
    () => GetNotes(getIt<NoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<CreateNote>(
    () => CreateNote(getIt<NoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<UpdateNote>(
    () => UpdateNote(getIt<NoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<DeleteNote>(
    () => DeleteNote(getIt<NoteRepositoryImpl>()),
  );
  getIt.registerFactory<NoteBloc>(
    () => NoteBloc(
      getNotes: getIt<GetNotes>(),
      createNote: getIt<CreateNote>(),
      updateNote: getIt<UpdateNote>(),
      deleteNote: getIt<DeleteNote>(),
    ),
  );
}