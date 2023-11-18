/// model : "text-davinci-003"
/// prompt : "Translate this into 1. French, 2. Spanish and 3. Japanese:\n\nWhat rooms do you have available?\n\n1."
/// temperature : 0.3
/// max_tokens : 100
/// top_p : 1.0
/// frequency_penalty : 0.0
/// presence_penalty : 0.0

class Translate {
  Translate({
      String? model, 
      String? prompt, 
      num? temperature, 
      num? maxTokens, 
      num? topP, 
      num? frequencyPenalty, 
      num? presencePenalty,}){
    _model = model;
    _prompt = prompt;
    _temperature = temperature;
    _maxTokens = maxTokens;
    _topP = topP;
    _frequencyPenalty = frequencyPenalty;
    _presencePenalty = presencePenalty;
}

  Translate.fromJson(dynamic json) {
    _model = json['model'];
    _prompt = json['prompt'];
    _temperature = json['temperature'];
    _maxTokens = json['max_tokens'];
    _topP = json['top_p'];
    _frequencyPenalty = json['frequency_penalty'];
    _presencePenalty = json['presence_penalty'];
  }
  String? _model;
  String? _prompt;
  num? _temperature;
  num? _maxTokens;
  num? _topP;
  num? _frequencyPenalty;
  num? _presencePenalty;
Translate copyWith({  String? model,
  String? prompt,
  num? temperature,
  num? maxTokens,
  num? topP,
  num? frequencyPenalty,
  num? presencePenalty,
}) => Translate(  model: model ?? _model,
  prompt: prompt ?? _prompt,
  temperature: temperature ?? _temperature,
  maxTokens: maxTokens ?? _maxTokens,
  topP: topP ?? _topP,
  frequencyPenalty: frequencyPenalty ?? _frequencyPenalty,
  presencePenalty: presencePenalty ?? _presencePenalty,
);
  String? get model => _model;
  String? get prompt => _prompt;
  num? get temperature => _temperature;
  num? get maxTokens => _maxTokens;
  num? get topP => _topP;
  num? get frequencyPenalty => _frequencyPenalty;
  num? get presencePenalty => _presencePenalty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['model'] = _model;
    map['prompt'] = _prompt;
    map['temperature'] = _temperature;
    map['max_tokens'] = _maxTokens;
    map['top_p'] = _topP;
    map['frequency_penalty'] = _frequencyPenalty;
    map['presence_penalty'] = _presencePenalty;
    return map;
  }

}