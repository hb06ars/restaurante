package brandaoti.sistema.controle.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import brandaoti.sistema.controle.dao.CategoriaDao;
import brandaoti.sistema.controle.dao.MesaDao;
import brandaoti.sistema.controle.dao.PerfilDao;
import brandaoti.sistema.controle.dao.ProdutoDao;
import brandaoti.sistema.controle.dao.UsuarioDao;
import brandaoti.sistema.controle.dao.VendaDao;
import brandaoti.sistema.controle.model.Categoria;
import brandaoti.sistema.controle.model.Mesa;
import brandaoti.sistema.controle.model.Perfil;
import brandaoti.sistema.controle.model.Produto;
import brandaoti.sistema.controle.model.Usuario;
import brandaoti.sistema.controle.model.Venda;


@Controller
public class ControleController {
	
	@Autowired
	private UsuarioDao usuarioDao;
	@Autowired
	private PerfilDao perfilDao;
	@Autowired
	private MesaDao mesaDao;
	@Autowired
	private CategoriaDao categoriaDao;
	@Autowired
	private ProdutoDao produtoDao;
	@Autowired
	private VendaDao vendaDao;
	
	public static Usuario usuarioSessao;
	public static String atualizarPagina = null;
	public static String mensagem = "";
	public static String tituloMensagem = "";
	public static String tipoMensagem = "";
	public static String periodoAtual = "";
	public static String hoje = "";
	public static String itemMenuSelecionado = "home";
	
	public String verificaLink(String link) {
		String direcao = "deslogar";
		if(usuarioSessao != null) {
			direcao = link;
			itemMenuSelecionado = link;
		} else {
			direcao = "deslogar";
			atualizarPagina = null;
			itemMenuSelecionado = "home";
		}
		return direcao;
	}
	
	public void registraMsg(String titulo, String msg, String tipo) {
		tituloMensagem = titulo;
		mensagem = msg;
		tipoMensagem = tipo;
	}
	
	public ModelAndView enviaMsg(ModelAndView modelAndView) {
		modelAndView.addObject("mensagem", mensagem);
		modelAndView.addObject("tituloMensagem", tituloMensagem);
		modelAndView.addObject("tipoMensagem", tipoMensagem);
		mensagem = null;
		tituloMensagem = null;
		tipoMensagem = null;
		return modelAndView;
	}
	
	
	
	public String diaDaSemana() {
		Date d = new Date();
		Calendar c = new GregorianCalendar();
		c.setTime(d);
		String nome = "";
		int dia = c.get(c.DAY_OF_WEEK);
		switch(dia){
		case Calendar.SUNDAY: nome = "Domingo";
			break;
		case Calendar.MONDAY: nome = "Segunda";
			break;
		case Calendar.TUESDAY: nome = "Terça";
			break;
		case Calendar.WEDNESDAY: nome = "Quarta";
			break;
		case Calendar.THURSDAY: nome = "Quinta";
			break;
		case Calendar.FRIDAY: nome = "Sexta";
			break;
		case Calendar.SATURDAY: nome = "Sábado";
			break;
		}
		return nome;
	}
	
	public void hoje() {
		Calendar c = Calendar.getInstance();
		int ano = c.get(Calendar.YEAR);
		int m = c.get(Calendar.MONTH);
		m++;
		String mes = ""+m;
		if(m < 10){
		    mes = "0"+m;
		}
		int d = c.get(Calendar.DAY_OF_MONTH);
        String dia=""+d;
		if(d < 10){
		    dia = "0"+d;
		}
		hoje = ano+"-"+mes+"-"+dia;
	}
	
	@GetMapping({"/","/index"}) 
		public ModelAndView index(Model model) { 
		ModelAndView modelAndView = new ModelAndView("index");
		List<Usuario> usuarios = usuarioDao.findAll();
		List<Perfil> perfis = perfilDao.findAll();
		hoje();
		if(perfis.size() == 0) {
			Perfil p = new Perfil();
			p.setAtivo(true);
			p.setNome("Admnistrador");
			p.setCodigo("1");
			p.setAdmin(true);
			p.setFuncionario(true);
			perfilDao.save(p);
			
			p = new Perfil();
			p.setAtivo(true);
			p.setNome("Funcionário");
			p.setCodigo("2");
			p.setAdmin(false);
			p.setFuncionario(true);
			perfilDao.save(p);

		}
		if(usuarios.size() == 0) {
			Usuario u = new Usuario();
			u.setAtivo(true);
			u.setTelefone("(11)98937-6271");
			u.setPerfil(perfilDao.buscarAdm().get(0));
			u.setLogin("hb06ars");
			u.setNome("Henrique Brandão");
			u.setSenha("kzdut");
			usuarioDao.save(u);
		}
		
		// EXCLUIR ----------------------
		if(mesaDao.findAll().size() == 0) {
			for(int i = 0; i < 10; i++) {
				Mesa m = new Mesa();
				m.setAtivo(true);
				m.setNumeroDaMesa(i+1);
				mesaDao.save(m);
			}
		}
		if(categoriaDao.findAll().size() == 0) {
			Categoria doces = new Categoria();
			doces.setAtivo(true);
			doces.setDescricao("DOCES");
			categoriaDao.save(doces);
			Categoria salgados = new Categoria();
			salgados.setAtivo(true);
			salgados.setDescricao("SALGADOS");
			categoriaDao.save(salgados);
			Categoria bebidas = new Categoria();
			bebidas.setAtivo(true);
			bebidas.setDescricao("BEBIDAS");
			categoriaDao.save(bebidas);
			Categoria sobremesas = new Categoria();
			sobremesas.setAtivo(true);
			sobremesas.setDescricao("SOBREMESAS");
			categoriaDao.save(sobremesas);
		}
		if(produtoDao.findAll().size() == 0) {
			Produto p = new Produto();
			p.setAtivo(true);
			p.setCodigo("1");
			p.setDescricao("BRIGADEIRO");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("DOCES"));
			produtoDao.save(p);
			
			p = new Produto();
			p.setAtivo(true);
			p.setCodigo("2");
			p.setDescricao("COXINHA");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("SALGADOS"));
			produtoDao.save(p);
			
			p = new Produto();
			p.setAtivo(true);
			p.setCodigo("3");
			p.setDescricao("COCA-COLA");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("BEBIDAS"));
			produtoDao.save(p);
			
			p = new Produto();
			p.setAtivo(true);
			p.setCodigo("4");
			p.setDescricao("BOLO");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("SOBREMESAS"));
			produtoDao.save(p);
		}
		
		
		// EXCLUIR ----------------------
		
		
		
		model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
		return modelAndView; 
	}
	
	@GetMapping(value = "/deslogar")
	public ModelAndView deslogar(Model model) {  
		String link = "/deslogar";
		usuarioSessao = null;
		ModelAndView modelAndView = new ModelAndView(link); 
		return modelAndView; 
	}
	
	
	@RequestMapping(value = "/adm/deletando/{tabela}/{id}", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE}) // Pagina de Alteração de Perfil
	public ModelAndView deletando(Model model,@PathVariable("tabela") String tabela, @PathVariable("id") Integer id) { //Função e alguns valores que recebe...
		String link = verificaLink("/deslogar");
		if(usuarioSessao.getPerfil().getAdmin()) {
			model.addAttribute("usuarioSessao", usuarioSessao);
			link = "/pages/"+tabela;
			if(tabela.equals("token")) {
				atualizarPagina = "/token";
				Usuario objeto = usuarioDao.findById(id).get();
				if(objeto != null)
					usuarioDao.deleteById(id);
				usuarioDao.flush();
				List<Usuario> tokens = usuarioDao.buscaTokens();
				model.addAttribute("atualizarPagina", atualizarPagina);
				model.addAttribute("tokens", tokens);
				model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Token", "Deletado com sucesso.", "erro");
			}
			
			if(tabela.equals("excluirUsuario")) {
				link = verificaLink("pages/adversario");
				atualizarPagina = "/adversario";
				Usuario objeto = usuarioDao.findById(id).get();
				if(objeto != null) {
					usuarioDao.deleteById(objeto.getId());
					usuarioDao.flush();
				}
				List<Usuario> adversario = usuarioDao.funcionario();
				model.addAttribute("adversario", adversario);
				model.addAttribute("atualizarPagina", atualizarPagina);
				model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Funcionário", "Deletado com sucesso.", "erro");
			}
			
		}
		ModelAndView modelAndView = new ModelAndView(link);
		enviaMsg(modelAndView);
		return modelAndView; 
	}

	
	
	@RequestMapping(value = "/criar", method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView criar(Model model, Usuario usuario, String codigoAcesso, String confirmaSenha) {  
		String link = "/criar";
		String erro="";
		String msg="";
		if(codigoAcesso != null && confirmaSenha != null) {
			if(!codigoAcesso.equals("") && !confirmaSenha.equals("")) {
				if(confirmaSenha.equals(usuario.getSenha())) {
					if(usuario.getLogin() != null) {
						if(!usuario.getLogin().replace(" ", "").equals("") && !usuario.getLogin().replace(" ", "").equals(" ")) {
							List<Usuario> u = usuarioDao.buscaLogin(usuario.getLogin());
							if(u.size() == 0) {
								Usuario user = usuarioDao.buscaAcesso(codigoAcesso);
								if(user != null) {
									user.setAtivo(true);
									user.setLogin(usuario.getLogin().replace(" ", ""));
									user.setNome(usuario.getNome());
									user.setPerfil(perfilDao.buscarFuncionario().get(0));
									user.setSenha(usuario.getSenha());
									user.setTelefone(usuario.getTelefone());
									usuarioDao.save(user);
									
									
									msg = "Usuário "+usuario.getLogin()+" cadastrado com sucesso!";
								} else {
									erro = "Código de acesso inválido!";
									model.addAttribute("erro", erro);
								}
								model.addAttribute("msg", msg);
							} else {
								erro = "Login já existe.";
								model.addAttribute("erro", erro);
							}
						} else {
							erro = "Login inválido.";
							model.addAttribute("erro", erro);
						}
					}
				} else {
					erro = "Senha não confere com a confirmação";
					model.addAttribute("erro", erro);
				}
			}
		}	
		ModelAndView modelAndView = new ModelAndView(link); 
		return modelAndView; 
	}
	
	
	@RequestMapping(value = "/home", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public ModelAndView logar(Model model, @RequestParam(value = "usuarioVal", defaultValue = "", required=false ) String variavelUsuario, @RequestParam(value = "senhaVal", defaultValue = "", required=false ) String variavelSenha) { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		Usuario usu = usuarioDao.fazerLogin(variavelUsuario, variavelSenha);
		if(usu != null)
			usuarioSessao = usu;
		if(usu != null || usuarioSessao != null) {
			model.addAttribute("usuarioSessao", usuarioSessao);
		}
		List<Mesa> mesas = mesaDao.buscarMesas();
		List<Categoria> categorias = categoriaDao.buscarCategorias();
		List<Produto> produtos = produtoDao.buscarProdutos();
		
		List<Venda> vendas = vendaDao.mesaAberta();
		Double totalinicio = 0.0;
		for(Venda  ve : vendas) {
			totalinicio = totalinicio+ve.getSubtotal();
		}
		double d = totalinicio;
        String s = String.format("%.2f", d);
        s = s.replace(",", ".");
        
		String link = verificaLink("pages/home");
		model.addAttribute("totalinicio", s);
		model.addAttribute("mesas", mesas);
		model.addAttribute("vendas", vendas);
		model.addAttribute("categorias", categorias);
		model.addAttribute("produtos", produtos);
		model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
		ModelAndView modelAndView = new ModelAndView(link);
		return modelAndView; 
	}
	
	
	@RequestMapping(value = "/senha", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public ModelAndView senha(Model model, String confirmaSenha, String senhaAtual, String novaSenha, Usuario usuario) { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		if(usuarioSessao != null) {
			if(confirmaSenha != null) {
				if(!confirmaSenha.equals("")) {
					if(confirmaSenha.equals(novaSenha)) {
						if(usuarioSessao.getSenha().equals(senhaAtual)) {
							Usuario u = usuarioDao.findById(usuarioSessao.getId()).get();
							u.setSenha(novaSenha);
							usuarioDao.save(u);
							registraMsg("Senha", "Senha alterada com sucesso!.", "info");
						} else {
							registraMsg("Senha", "Senha inválida.", "erro");
						}
					} else {
						registraMsg("Senha", "Confirmação de senha não confere.", "erro");
					}
				}
			}
			model.addAttribute("usuarioSessao", usuarioSessao);
		}
		String link = verificaLink("pages/senha");
		model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
		ModelAndView modelAndView = new ModelAndView(link);
		enviaMsg(modelAndView);
		return modelAndView; 
	}
	
	
	
	
	
	@RequestMapping(value = "/token", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public ModelAndView token(Model model, Integer criarToken, Usuario usuario) { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		if(usuarioSessao != null) {
			if(criarToken != null) {
				if(criarToken == 1) {
					Usuario u = new Usuario();
					u.setAcesso(usuario.getAcesso());
					u.setAtivo(false);
					u.setNome(usuario.getNome());
					usuarioDao.save(u);
				}
			}
			List<Usuario> tokens = usuarioDao.buscaTokens();
			model.addAttribute("tokens", tokens);
			model.addAttribute("usuarioSessao", usuarioSessao);
		}
		String link = verificaLink("pages/token");
		model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
		ModelAndView modelAndView = new ModelAndView(link);
		return modelAndView; 
	}
	
	
	
	/* SALVAR VENDA */
	@RequestMapping(value = "/finalizarVenda", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public ModelAndView finalizaVenda(Model model, Boolean finalizar, Integer numeroMesa, String pedidoVenda, String notaDataVenda, String valorTotalVenda, String vendas) { //Fun��o e alguns valores que recebe...
		String link = verificaLink("/pages/home"); //Session
		ModelAndView modelAndView = new ModelAndView(link); //JSP que ir� acessar.
		
		//Ocupando a mesa...
    	Mesa m = mesaDao.buscarCodigo(numeroMesa);
		if(m == null)
			m = new Mesa();
		if(finalizar) {
			m.setReservada(false);
			m.setEntrada(null);
			m.setClienteQueReservou(null);
			m.setPaga(true);
			m.setOcupada(false);
			m.setTotal(0.0);
			m.setSaida(LocalDateTime.now());
		} else {
			m.setOcupada(true);
			m.setTotal(Double.parseDouble(valorTotalVenda));
		}
		m.setAtivo(true);
		m.setNumeroDaMesa(numeroMesa);
		m.setNota(pedidoVenda);
		if(m.getEntrada() == null)
			m.setEntrada(LocalDateTime.now());
		mesaDao.save(m);
		
		//Limpando pra inserir os itens:
		Mesa limpaMesas = mesaDao.buscarCodigo(numeroMesa);
		limpaMesas.setVendas(null);
		mesaDao.save(limpaMesas);
		
		List<Venda> v = vendaDao.vendaPorMesa(numeroMesa, pedidoVenda);
		for(Venda ve : v) {
			vendaDao.deleteById(ve.getVendaID());
			vendaDao.flush();
		}
		
		// Inserindo os produtos na mesa
		List<Venda> vendaList = new ArrayList<Venda>();
		try {
			JSONObject obj = new JSONObject(vendas);
			JSONArray arr = obj.getJSONArray("Produtos");
	        for (int i = 0; i < arr.length(); i++) {
	        	String codigo = arr.getJSONObject(i).getString("codigo");
	        	String qtd = arr.getJSONObject(i).getString("qtd");
	        	Produto pr = produtoDao.porCodigo(codigo);
				if(pr != null && pr.getCodigo() != null) {
	        		Venda venda = new Venda();
	        		venda.setPedido(pedidoVenda);
	        		venda.setMesa(mesaDao.buscarCodigo(numeroMesa));
	        		pr.setEstoque(pr.getEstoque() - Integer.parseInt(qtd));
	        		venda.setProdutos(pr);
	        		if(pr.getPrecoPromocional() > 0.0) {
	        			venda.setPrecoUnit((pr.getPrecoPromocional()));
	        		} else {
	        			venda.setPrecoUnit((pr.getValor()));
	        		}
	        		venda.setQuantidade(Integer.parseInt(qtd));
	        		venda.setSubtotal(Integer.parseInt(qtd) * (pr.getValor()));
	        		if(pr.getPrecoPromocional() > 0) {
	        			venda.setPromocao(true);
	        		}
	        		venda.setFuncionario(usuarioSessao);
	        		vendaDao.save(venda);
	        		vendaList.add(venda);
	        		produtoDao.save(pr);
	        	}
				
	        }
		}catch(Exception e) {
			System.out.println("Erro: "+ e);
			registraMsg("Erro na Venda", "Ocorreu um erro: " + e , "erro");
		}
		if(vendaList.size() > 0) {
			m.setVendas(vendaList);
			mesaDao.save(m);
		}
		
		
		
		List<Mesa> mesas = mesaDao.buscarMesas();
		List<Categoria> categorias = categoriaDao.buscarCategorias();
		List<Produto> produtos = produtoDao.buscarProdutos();
		link = verificaLink("pages/home");
		model.addAttribute("mesas", mesas);
		model.addAttribute("categorias", categorias);
		model.addAttribute("produtos", produtos);
		model.addAttribute("itemMenuSelecionado", itemMenuSelecionado);
		
		registraMsg("Venda", "Venda finalizada com sucesso.", "info");
		atualizarPagina = "/home";
		modelAndView.addObject("atualizarPagina", atualizarPagina);
		return modelAndView; //Retorna para a p�gina
	}
	
	
	
	
	

}
