class @AnswerModel extends Model
  defaults:
    answer_type : "radio"
    is_valid    : 0
    body        : ""

  toJSON: ->
    data = super
    data.cid = @cid
    data