class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur (X, O, ou vide), ainsi que son numéro de case)
  attr_accessor :value, :place

  
  def initialize(emplacement)
    #TO DO doit régler sa valeur, ainsi que son numéro de case
    @value = "rien"
    @place = emplacement
  end
  
  def to_s
    #TO DO : doit renvoyer la valeur au format string
    return @value.to_s
  end

end