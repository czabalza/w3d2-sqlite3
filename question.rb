class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_id(self_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, self_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    Question.new(results.first)
  end

  def self.find_by_author_id(self_author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, self_author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    results.map{ |result| Question.new(result) }
  end

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(author_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end
end
