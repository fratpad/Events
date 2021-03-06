import 'package:events/blocs/EventDetailsBloc.dart';
import 'package:events/models/Attendant.dart';
import 'package:events/models/Comment.dart';
import 'package:events/resources/AppColors.dart';
import 'package:events/resources/AppTextStyles.dart';
import 'package:events/resources/Dimens.dart';
import 'package:events/ui/common/Avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventDetailsReplyToCommentView extends StatefulWidget {
  final Comment _comment;
  final User _user;
  final EventDetailsBloc _bloc;

  EventDetailsReplyToCommentView(this._comment, this._user, this._bloc);

  @override
  State<StatefulWidget> createState() => _EventDetailsReplyToCommentView();
}

class _EventDetailsReplyToCommentView
    extends State<EventDetailsReplyToCommentView> {
  String _typedResponse = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: AppMargins.vertical,
        left: (AppMargins.horizontal + AppSizes.avatarRadius) * 2,
        right: AppMargins.horizontal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Avatar(widget._user.imagePath),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                left: AppMargins.horizontal,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Add a reply",
                ),
                enabled: !_isLoading,
                onChanged: (text) {
                  setState(() {
                    _typedResponse = text;
                  });
                },
                style: AppTextStyles.body,
              ),
            ),
          ),
          _SendOrLoadingButton(_isLoading, () {
            if (_typedResponse.isNotEmpty) {
              setState(() {
                widget._bloc.addReply(widget._comment, _typedResponse);
                _isLoading = true;
              });
            }
          }),
        ],
      ),
    );
  }
}

class _SendOrLoadingButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final bool _isLoading;

  _SendOrLoadingButton(this._isLoading, this._onPressed);

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator();
    } else {
      return IconButton(
        icon: Icon(
          Icons.send,
          color: AppColors.textPrimary,
        ),
        onPressed: _onPressed,
      );
    }
  }
}
