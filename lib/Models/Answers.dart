class AnswersModel {
    String status;
    String message;
    List<Answer> answers;

    AnswersModel({
        this.status,
        this.message,
        this.answers,
    });

    factory AnswersModel.fromJson(Map<String, dynamic> json) => new AnswersModel(
        status: json["status"],
        message: json["message"],
        answers: new List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "answers": new List<dynamic>.from(answers.map((x) => x.toJson())),
    };
}

class Answer {
    String question;
    String createdBy;
    String id;
    String optionA;
    String optionB;
    String optionC;
    String optionD;
    String acount;
    String bcount;
    String ccount;
    String dcount;
    String percentageA;
    String percentageB;
    String percentageC;
    String percentageD;
    String answer;

    Answer({
        this.question,
        this.createdBy,
        this.id,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.acount,
        this.bcount,
        this.ccount,
        this.dcount,
        this.percentageA,
        this.percentageB,
        this.percentageC,
        this.percentageD,
        this.answer,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => new Answer(
        question: json["question"],
        createdBy: json["createdBy"],
        id: json["id"],
        optionA: json["optionA"],
        optionB: json["optionB"],
        optionC: json["optionC"],
        optionD: json["optionD"],
        acount: json["Acount"],
        bcount: json["Bcount"],
        ccount: json["Ccount"],
        dcount: json["Dcount"],
        percentageA: json["percentageA"],
        percentageB: json["percentageB"],
        percentageC: json["percentageC"],
        percentageD: json["percentageD"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "createdBy": createdBy,
        "id": id,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
        "Acount": acount,
        "Bcount": bcount,
        "Ccount": ccount,
        "Dcount": dcount,
        "percentageA": percentageA,
        "percentageB": percentageB,
        "percentageC": percentageC,
        "percentageD": percentageD,
        "answer": answer,
    };
}
