class Deal
{
  int id;
  bool viewed;
  bool answered;
  bool inactive;
  int stepperUserProponent;
  int stepperUserProposed;

  Deal(
      this.id,
      this.viewed,
      this.answered,
      this.inactive,
      this.stepperUserProponent,
      this.stepperUserProposed
      );

  int get gId => id;
  bool get gViewed => viewed;
  bool get gAnswered => answered;
  bool get gInactive => inactive;
  int get gStepperUserProponent => stepperUserProponent;
  int get gStepperUserProposed => stepperUserProposed;

  // Converter o objeto JSON recebido para o meu modelo
  Deal.fromJson(dynamic json) :
    id = json['id'],
    viewed = json['viewed'],
    answered = json['answered'],
    inactive = json['inactive'],
    stepperUserProponent = json['stepperUserProponent'],
    stepperUserProposed = json['stepperUserProposed'];

  @override
  String toString() {
    return '{id: '+ gId.toString() +' viewed: '+ gViewed.toString() +' answered: '+ gAnswered.toString() +
            ' inactive: ' +gInactive.toString() + ' stepperUserProponent: ' +
            gStepperUserProponent.toString() + ' stepperUserProposed: ' + gStepperUserProponent.toString() +'}';
  }
}