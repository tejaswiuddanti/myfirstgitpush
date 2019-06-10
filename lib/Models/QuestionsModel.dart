class QuestionsModel {
    String status;
    String message;
    List<Question> questions;

    QuestionsModel({
        this.status,
        this.message,
        this.questions,
    });

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => new QuestionsModel(
        status: json["status"],
        message: json["message"],
        questions: new List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "questions": new List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
    String question;
    String id;
    String createdBy;
    String optionA;
    String optionB;
    String optionC;
    String optionD;

    Question({
        this.question,
        this.id,
        this.createdBy,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
    });

    factory Question.fromJson(Map<String, dynamic> json) => new Question(
        question: json["question"],
        id: json["id"],
        createdBy: json["createdBy"],
        optionA: json["optionA"],
        optionB: json["optionB"],
        optionC: json["optionC"],
        optionD: json["optionD"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "id": id,
        "createdBy": createdBy,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
    };
}
