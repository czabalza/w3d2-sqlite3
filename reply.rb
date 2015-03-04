class Reply
  attr_accessor :id, :parent_id, :question_id, :user_id

  def self.find_by_id(self_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, self_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    Reply.new(results.first)
  end

  def self.find_by_question_id(s_question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, s_question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    results.map{ |result| Reply.new(result) }
  end

  def self.find_by_parent_id(s_parent_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, s_parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    results.map{ |result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    results.map{ |result| Reply.new(result) }
  end

  def initialize(options = {})
    @id = options['id']
    @body = options['body']
    @question_id = options['question_id']
    @parent_id = options['parent_id']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    results.map{ |result| Reply.new(result) }
  end
end
