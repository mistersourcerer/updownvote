module SpecHelpers

  def auth_hash
    {
      "uid" => "123",
      "info" => {
        "name"      => "Ricardo Valeriudo",
        "email"     => "ricardo@omg.email",
        "nickname"  => "ricardovaleriano",
        "urls"      => {"GitHub" => "OMG.LOL.githubz/ricardolho!"}
      },
      "extra" => {
        "raw_info" => {
          "omg" => "some data"
        }
      }
    }
  end

end
