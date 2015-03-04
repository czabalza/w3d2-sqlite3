class QuestionLike
  attr_accessor :id, :question_id, :user_id

  def self.find_by_id(self_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, self_id)
      SELECT
        *
      FROM
        questions_likes
      WHERE
        id = ?
    SQL
    QuestionLike.new(results.first)
  end

  def self.find_by_question_id(s_question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, s_question_id)
      SELECT
        *
      FROM
        questions_likes
      WHERE
        question_id = ?
    SQL
    results.map{ |result| QuestionLike.new(result) }
  end

  def self.find_by_user_id(s_user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, s_user_id)
      SELECT
        *
      FROM
        questions_likes
      WHERE
        user_id = ?
    SQL
    results.map{ |result| QuestionLike.new(result) }
  end

  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
end
