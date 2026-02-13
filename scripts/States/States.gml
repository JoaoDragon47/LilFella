function State() constructor {
	///@description Função chamada quando um estado é iniciado. É chamada automaticamente quando há a troca de estados (o novo estado que executa a função de 'start').
	start = function() {return}
	
	///@description Função chamada durante o 'Step' do objeto.
	step = function() {return}
	
	///@description Função chamada antes do estado atual ser alterado para um novo.
	stop = function() {return}
}


function run_state() {
	state.step()
}


///@description Função responsável por fazer a troca do estado atual para outro.
///@param {Struct.State} new_state
function change_state(_new_state) {
	state.stop()
	state = _new_state
	state.start()
}


///@description Função responsável por iniciar um estado.
///@param {Struct.State} new_state
function init_state(_state) {
	if (!variable_instance_exists(self, "state")) {
		show_error("O objeto atual não possui a variável 'state'. Por favor, adicione essa variável antes de chamar essa função.", true)
		exit
	}
	state = _state
	state.start()
}