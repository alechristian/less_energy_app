// lib/models/messages.dart
import 'package:flutter/material.dart';

class Message {
  final String text;
  final IconData icon;
  final String local;
  final String event;

  Message(
      {required this.text,
      required this.icon,
      required this.local,
      required this.event});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'icon': icon.codePoint,
      'local': local,
      'event': event,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      local: json['local'],
      event: json['event'],
    );
  }
}

final List<Message> messages = [
  Message(
    text: 'Você desligou as luzes antes de sair de casa?',
    icon: Icons.lightbulb_outline,
    local: 'house',
    event: 'leaving',
  ),
  Message(
    text:
        'Você está na Universidade. Ao ligar o ar condicionado, lembre-se de fechar as janelas',
    icon: Icons.ac_unit,
    local: 'university',
    event: 'arriving',
  ),
  Message(
    text:
        'Desligue os aparelhos eletrônicos quando não estiverem em uso em seu trabalho',
    icon: Icons.power_settings_new,
    local: 'work',
    event: 'arriving',
  ),
  Message(
    text:
        'Que bom que voce chegou em casa! Use lâmpadas de LED para economizar energia',
    icon: Icons.lightbulb,
    local: 'house',
    event: 'arriving',
  ),
  Message(
    text: 'Aproveite a luz natural durante o dia',
    icon: Icons.wb_sunny,
    local: 'house',
    event: 'arriving',
  ),
];
