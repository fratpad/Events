import 'dart:async';

import 'package:events/models/Comment.dart';
import 'package:events/models/Event.dart';
import 'package:events/models/EventDetails.dart';
import 'package:events/models/Reply.dart';
import 'package:events/repositories/mock/MockEventsRepository.dart';

abstract class EventsRepository {
  Future<List<Event>> fetchAllEvents();

  Future<EventDetails> fetchEventDetails(String eventId);

  Future<Comment> addReply(Reply reply);
}

final eventsRepository = mockEventsRepository;
