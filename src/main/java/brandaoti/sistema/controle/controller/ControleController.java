package brandaoti.sistema.controle.controller;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import brandaoti.sistema.controle.dao.CategoriaDao;
import brandaoti.sistema.controle.dao.MesaDao;
import brandaoti.sistema.controle.dao.PerfilDao;
import brandaoti.sistema.controle.dao.ProdutoDao;
import brandaoti.sistema.controle.dao.UsuarioDao;
import brandaoti.sistema.controle.dao.VendaDao;
import brandaoti.sistema.controle.excel.Tabela;
import brandaoti.sistema.controle.model.Categoria;
import brandaoti.sistema.controle.model.Mesa;
import brandaoti.sistema.controle.model.Perfil;
import brandaoti.sistema.controle.model.Produto;
import brandaoti.sistema.controle.model.Usuario;
import brandaoti.sistema.controle.model.Venda;


@Controller
public class ControleController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
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
	
	//public static Usuario usuarioSessao;
	//public static String atualizarPagina = null;
	public static String mensagem = "";
	public static String tituloMensagem = "";
	public static String tipoMensagem = "";
	public static String periodoAtual = "";
	public static String hoje = "";
	//public static String itemMenuSelecionado = "home";
	
	public void registraMsg(String titulo, String msg, String tipo) {
		tituloMensagem = titulo;
		mensagem = msg;
		tipoMensagem = tipo;
	}
	
	public HttpServletRequest enviaMsg(HttpServletRequest request) {
		request.setAttribute("mensagem", mensagem);
		request.setAttribute("tituloMensagem", tituloMensagem);
		request.setAttribute("tipoMensagem", tipoMensagem);
		mensagem = null;
		tituloMensagem = null;
		tipoMensagem = null;
		return request;
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
	
	@RequestMapping(value = {"/","/index"}, method = {RequestMethod.GET})
		public void index(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException { 
		HttpSession session = request.getSession();
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
			u.setLogin("adm");
			u.setNome("Henrique Brandão");
			u.setSenha("adm");
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
			p.setDescricao("RISOLE");
			p.setValor(2.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("SALGADOS"));
			produtoDao.save(p);
			
			p = new Produto();
			p.setAtivo(true);
			p.setCodigo("4");
			p.setDescricao("COCA-COLA");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("BEBIDAS"));
			produtoDao.save(p);
			
			p = new Produto();
			p.setAtivo(true);
			p.setCodigo("5");
			p.setDescricao("BOLO");
			p.setValor(5.40);
			p.setCategoria(categoriaDao.buscarDeterminadaCategoria("SOBREMESAS"));
			produtoDao.save(p);
		}
		
		
		// EXCLUIR ----------------------
		
		
		
		request.setAttribute("itemMenuSelecionado", "home");
		if(session.getAttribute("usuarioSessao") != null) {
			response.sendRedirect("/home");
		} else {
			request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
		}
	}
	
	
	
	
	/* SALVAR EXCEL */
	@Transactional
	@RequestMapping(value = "/upload/excel", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public void uploadExcel(HttpServletRequest request, HttpServletResponse response, String tabelaUsada, @ModelAttribute MultipartFile file) throws Exception, IOException { //Fun��o e alguns valores que recebe...
		String link = "/pages/home"; //Session
		String atualizarPagina = "";
		HttpSession session = request.getSession();
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getPerfil() != null && usuarioSessao.getPerfil().getAdmin()) {
			switch (tabelaUsada) {  
		       case "produtos" :
		    	   processaProduto(file);
		    	   link = "/pages/produtos";
		    	   atualizarPagina = "/produtos";
		    	   break;
		       case "usuarios" :
		    	   processaUsuario(file);
		    	   link = "/pages/usuarios";
		    	   atualizarPagina = "/usuarios";
		    	   break;
			}
			registraMsg("Excel", "Dados inseridos com sucesso..", "info");
		}
		request.setAttribute("atualizarPagina", atualizarPagina);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //Retorna para a p�gina
	}
	
	
	
@SuppressWarnings("deprecation")
public List<Tabela> uploadExcelFile(@ModelAttribute MultipartFile file) throws Exception {
		List<Tabela> tabelas = new ArrayList<Tabela>();
		int linha = 1;
		int coluna = 0;
		try {
			InputStream in = file.getInputStream();
		    XSSFWorkbook workbook = new XSSFWorkbook(in);
		    XSSFSheet sheet = workbook.getSheet("Sheet1");
		    if(sheet == null) {
				sheet = workbook.getSheet("Plan1");
			}
		    if(sheet == null) {
				sheet = workbook.getSheet("Planilha1");
			}
			Iterator<Row> rowIterator = sheet.rowIterator();
			while (rowIterator.hasNext()) {
				coluna = 0;
				Row row = rowIterator.next();
				if (row.getRowNum() == 0) {
					continue;
				}
				Iterator<Cell> cellIterator = row.cellIterator();
				while (cellIterator.hasNext()) {
					Cell cell = cellIterator.next();
						if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
							Tabela tabela = new Tabela();
							tabela.setLinha(linha);
							tabela.setConteudo(cell.getStringCellValue());
							tabela.setColuna(coluna);
							tabelas.add(tabela);
						}
						else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
							Tabela tabela = new Tabela();
							tabela.setLinha(linha);
							tabela.setConteudo(cell.getNumericCellValue() + "");
							tabela.setColuna(coluna);
							tabelas.add(tabela);
						}
					coluna++;
				}
				linha++;
			}
		    in.close();
		    workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
		return tabelas;
	}


	
	
	
	@GetMapping(value = "/deslogar")
	public void deslogar(HttpServletRequest request, HttpServletResponse response) throws IOException {  
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("/");
	}
	
	
	@RequestMapping(value = "/adm/deletando/{tabela}/{id}", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE}) // Pagina de Alteração de Perfil
	public void deletando(HttpServletRequest request, HttpServletResponse response,@PathVariable("tabela") String tabela, @PathVariable("id") Integer id) throws ServletException, IOException { //Função e alguns valores que recebe...
		String link = "/deslogar";
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao.getPerfil().getAdmin()) {
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "/pages/"+tabela;
			if(tabela.equals("token")) {
				atualizarPagina = "/token";
				Usuario objeto = usuarioDao.findById(id).get();
				if(objeto != null)
					usuarioDao.deleteById(id);
				usuarioDao.flush();
				List<Usuario> tokens = usuarioDao.buscaTokens();
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("tokens", tokens);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Token", "Deletado com sucesso.", "erro");
			}
			if(tabela.equals("excluirUsuario")) {
				link = "pages/usuarios";
				atualizarPagina = "/usuarios";
				Usuario objeto = usuarioDao.findById(id).get();
				if(objeto != null) {
					usuarioDao.deleteById(objeto.getId());
					usuarioDao.flush();
				}
				List<Usuario> usuario = usuarioDao.funcionario();
				request.setAttribute("usuario", usuario);
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Funcionário", "Deletado com sucesso.", "erro");
			}
			if(tabela.equals("produto")) {
				link = "pages/produtos";
				atualizarPagina = "/produtos";
				Produto objeto = produtoDao.findById(id).get();
				if(objeto != null) {
					try {
						produtoDao.deleteById(objeto.getId());
						produtoDao.flush();
					} catch(Exception e) {
						Produto p = produtoDao.findById(objeto.getId()).get();
						p.setAtivo(false);
						produtoDao.save(p);
					}
					
				}
				List<Produto> produtos = produtoDao.buscarProdutos();
				request.setAttribute("produtos", produtos);
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Produto", "Deletado com sucesso.", "erro");
			}
			if(tabela.equals("categoria")) {
				link = "pages/categorias";
				atualizarPagina = "/categorias";
				Categoria objeto = categoriaDao.findById(id).get();
				if(objeto != null) {
					try {
						categoriaDao.deleteById(objeto.getId());
						categoriaDao.flush();
					} catch(Exception e) {
						Categoria p = categoriaDao.findById(objeto.getId()).get();
						p.setAtivo(false);
						categoriaDao.save(p);
					}
					
				}
				List<Categoria> categorias = categoriaDao.buscarCategorias();
				request.setAttribute("categorias", categorias);
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Categoria", "Deletada com sucesso.", "erro");
			}
			if(tabela.equals("usuario")) {
				link = "pages/usuarios";
				atualizarPagina = "/usuarios";
				Usuario objeto = usuarioDao.findById(id).get();
				if(objeto != null) {
					try {
						usuarioDao.deleteById(objeto.getId());
						usuarioDao.flush();
					} catch(Exception e) {
						Usuario p = usuarioDao.findById(objeto.getId()).get();
						p.setAtivo(false);
						usuarioDao.save(p);
					}
					
				}
				List<Usuario> usuarios = usuarioDao.usuarios();
				request.setAttribute("usuarios", usuarios);
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Usuário", "Usuário com sucesso.", "erro");
			}
			
		}
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	@RequestMapping(value = "deletandoVenda/{tabela}/{id}", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE}) // Pagina de Alteração de Perfil
	public void deletandoVenda(HttpServletRequest request, HttpServletResponse response,@PathVariable("tabela") String tabela, @PathVariable("id") String id) throws ServletException, IOException { //Função e alguns valores que recebe...
		String link = "/deslogar";
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao.getPerfil().getAdmin()) {
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "/pages/"+tabela;
			if(tabela.equals("venda")) {
				link = "pages/pedidos";
				atualizarPagina = "/pedidos";
				List<Venda> vendas = vendaDao.nota(id);
				System.out.println("SIZE: "+vendas.size());
				if(vendas != null && vendas.size() > 0) {
					try {
						for(Venda v : vendas) {
							vendaDao.deleteById(v.getVendaID());
							vendaDao.flush();
						}
					} catch(Exception e) {
						for(Venda v : vendas) {
							v.setAtivo(false);
							vendaDao.save(v);
						}
					}
				}
				List<Venda> venda = vendaDao.ultimas();
				request.setAttribute("venda", venda);
				request.setAttribute("atualizarPagina", atualizarPagina);
				request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
				registraMsg("Venda", "Deletada com sucesso.", "erro");
			}
		}
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	

	
	
	@RequestMapping(value = "/criar", method = {RequestMethod.POST,RequestMethod.GET})
	public void criar(HttpServletRequest request, HttpServletResponse response, Usuario usuario, String codigoAcesso, String confirmaSenha) throws ServletException, IOException {  
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
									if(usuario.getSenha() == null) {
										user.setSenha(usuario.getLogin().replace(" ", ""));
									} else {
										user.setSenha(usuario.getSenha());
									}	
									user.setTelefone(usuario.getTelefone());
									usuarioDao.save(user);
									msg = "Usuário "+usuario.getLogin()+" cadastrado com sucesso!";
								} else {
									erro = "Código de acesso inválido!";
									request.setAttribute("erro", erro);
								}
								request.setAttribute("msg", msg);
							} else {
								erro = "Login já existe.";
								request.setAttribute("erro", erro);
							}
						} else {
							erro = "Login inválido.";
							request.setAttribute("erro", erro);
						}
					}
				} else {
					erro = "Senha não confere com a confirmação";
					request.setAttribute("erro", erro);
				}
			}
		}	
		 
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	@RequestMapping(value = "/home", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void logar(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "usuarioVal", defaultValue = "", required=false ) String variavelUsuario, @RequestParam(value = "senhaVal", defaultValue = "", required=false ) String variavelSenha) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		Usuario usu = usuarioDao.fazerLogin(variavelUsuario, variavelSenha);
		HttpSession session = request.getSession();
		Usuario usuarioSessao = new Usuario();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		String link = "deslogar";
		if(usu != null) {
			usuarioSessao = usu;
			session.setAttribute("usuarioSessao", usuarioSessao);
			request.setAttribute("usuarioSessao", usuarioSessao);
		}
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
			request.setAttribute("usuarioSessao", usuarioSessao);
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
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
	        
			link = "pages/home";
			itemMenuSelecionado = "home";
			request.setAttribute("totalinicio", s);
			request.setAttribute("mesas", mesas);
			request.setAttribute("vendas", vendas);
			request.setAttribute("categorias", categorias);
			request.setAttribute("produtos", produtos);
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		}
		
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	@RequestMapping(value = "/senha", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void senha(HttpServletRequest request, HttpServletResponse response, String confirmaSenha, String senhaAtual, String novaSenha, Usuario usuario) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			link = "pages/senha";
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
			request.setAttribute("usuarioSessao", usuarioSessao);
		}
		request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	@RequestMapping(value = "/cadastroMesas", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void cadastroMesas(HttpServletRequest request, HttpServletResponse response, Integer mesas) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			link = "pages/cadastroMesas";
			Integer m = mesaDao.buscarMesas().size();
			//Deletando mesas a mais.
			if(mesas != null && mesas > 0) {
				if(m > mesas) {
					for(int i = m; i > mesas; i--) {
						Integer numeroDaMesa = mesaDao.buscarCodigo(i).getNumeroDaMesa();
						if(numeroDaMesa != null) {
							List<Venda> v = vendaDao.vendaSomenteMesa(numeroDaMesa);
							for(Venda ve : v) {
								vendaDao.deleteById(ve.getVendaID());
								vendaDao.flush();
							}
							Mesa mesa = mesaDao.buscarCodigo(i);
							if(mesa != null) {
								mesaDao.deleteById(mesa.getId());
								mesaDao.flush();
							}
						}
					}
				} else if(m < mesas) {
					//Adicionando mesas a mais.
					for(int i = m+1; i <= mesas; i++) {
						Mesa mesa = new Mesa();
						mesa.setAtivo(true);
						mesa.setNumeroDaMesa(i);
						mesaDao.save(mesa);
					}
				}
			}
		m = mesaDao.buscarMesas().size();
		request.setAttribute("totalMesas", m);
		request.setAttribute("usuarioSessao", usuarioSessao);
		request.setAttribute("mesas", mesas);
		request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		}
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	@RequestMapping(value = "/produtos", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void produtos(HttpServletRequest request, HttpServletResponse response, Produto produto) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			List<Produto> produtos = produtoDao.buscarProdutos();
			List<Categoria> categorias = categoriaDao.buscarCategorias();
			request.setAttribute("categorias", categorias);
			request.setAttribute("produtos", produtos);
			request.setAttribute("usuarioSessao", usuarioSessao);
			itemMenuSelecionado = "produto";
			link = "pages/produtos";
		}
		request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	@RequestMapping(value = "/categorias", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void categorias(HttpServletRequest request, HttpServletResponse response, Categoria categoria) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			List<Categoria> categorias = categoriaDao.buscarCategorias();
			request.setAttribute("categorias", categorias);
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "pages/categorias";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			
		}
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	@RequestMapping(value = "/usuarios", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void usuarios(HttpServletRequest request, HttpServletResponse response, Usuario usuario) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			List<Usuario> usuarios = usuarioDao.usuarios();
			request.setAttribute("usuarios", usuarios);
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "pages/usuarios";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		}
		
		enviaMsg(request);
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	@RequestMapping(value = "/token", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void token(HttpServletRequest request, HttpServletResponse response, Integer criarToken, Usuario usuario) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
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
			request.setAttribute("tokens", tokens);
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "pages/token";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
		}
		
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	/* SALVAR VENDA */
	@RequestMapping(value = "/finalizarVenda", method = {RequestMethod.POST, RequestMethod.GET}) // Pagina de Altera��o de Perfil
	public void finalizaVenda(HttpServletRequest request, HttpServletResponse response, Boolean cancelar, Boolean finalizar, Integer numeroMesa, String pedidoVenda, String notaDataVenda, String valorTotalVenda, String vendas) throws ServletException, IOException { //Fun��o e alguns valores que recebe...
		ModelAndView modelAndView = new ModelAndView("deslogar"); //JSP que ira acessar.
		Mesa m = mesaDao.buscarCodigo(numeroMesa);
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		String link = "deslogar";
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			link = "/pages/home"; //Session
			modelAndView = new ModelAndView(link); //JSP que ira acessar.
			if(cancelar && m != null) {
				// Limpa a mesa cancelada...		
				m.setReservada(false);
				m.setNota(null);
				m.setEntrada(null);
				m.setClienteQueReservou(null);
				m.setPaga(false);
				m.setOcupada(false);
				m.setTotal(0.0);
				m.setSaida(null);
				
				for(Venda vc : m.getVendas()) {
					vc.setAtivo(false);
					vc.setCancelada(true);
					vendaDao.save(vc);
				}
				
			} else {
				//Ocupando a mesa...
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
			}
			
			
			
			
			
			List<Mesa> mesas = mesaDao.buscarMesas();
			List<Categoria> categorias = categoriaDao.buscarCategorias();
			List<Produto> produtos = produtoDao.buscarProdutos();
			link = "pages/home";
			request.setAttribute("mesas", mesas);
			request.setAttribute("categorias", categorias);
			request.setAttribute("produtos", produtos);
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			
			registraMsg("Venda", "Venda finalizada com sucesso.", "info");
			atualizarPagina = "/home";
			request.setAttribute("atualizarPagina", atualizarPagina);
			
			
		}
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //Retorna para a p�gina
	}
	
	
	
	
	@RequestMapping(value = "/atualizarProduto", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void atualizarProduto(HttpServletRequest request, HttpServletResponse response, Integer produtoID, Boolean alterar, Boolean salvar, Boolean pesquisar, Produto produto, Integer produto_categoria) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		System.out.println("alterar: "+alterar);
		System.out.println("salvar:"+salvar);
		System.out.println("pesquisar:"+pesquisar);
		System.out.println("produtoID:"+produtoID);
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		ModelAndView modelAndView = new ModelAndView("deslogar");
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			if(pesquisar) {
				Produto p = produtoDao.porCodigo(produto.getCodigo());
				if(p != null) {
					request.setAttribute("produto", p);
				} else {
					List<Produto> produtos = produtoDao.buscarProdutos();
					request.setAttribute("produto", produtos);
					registraMsg("Produto", "Nenhum produto encontrado.", "erro");
				}
			} 
			else if (salvar) {
				Produto p = new Produto();
				p.setAtivo(true);
				try{
					p.setCategoria(categoriaDao.findById(produto_categoria).get());
				} catch(Exception e) {
					registraMsg("Categoria", "Categoria não encontrada.", "erro");
				}
				p.setCodigo(produto.getCodigo());
				p.setDescricao(produto.getDescricao());
				p.setDetalhes(produto.getDetalhes());
				p.setEstoque(produto.getEstoque());
				p.setPrecoPromocional(produto.getPrecoPromocional());
				p.setValor(produto.getValor());
				produtoDao.save(p);
								
				List<Produto> produtos = produtoDao.buscarProdutos();
				request.setAttribute("produto", produtos);
				registraMsg("Produto", "Alterado com sucesso.", "info");
			}
			else if (alterar) {
				System.out.println("alterar "+produtoID);
				Produto p = produtoDao.findById(produtoID).get();
				if(p != null) {
					p.setAtivo(true);
					try{
						p.setCategoria(categoriaDao.findById(produto_categoria).get());
					} catch(Exception e) {
						registraMsg("Categoria", "Categoria não encontrada.", "erro");
					}
					p.setCodigo(produto.getCodigo());
					p.setDescricao(produto.getDescricao());
					p.setDetalhes(produto.getDetalhes());
					p.setEstoque(produto.getEstoque());
					p.setPrecoPromocional(produto.getPrecoPromocional());
					p.setValor(produto.getValor());
					produtoDao.save(p);
				} else {
					registraMsg("Produto", "Produto não encontrado.", "erro");
				}
				List<Produto> produtos = produtoDao.buscarProdutos();
				request.setAttribute("produto", produtos);
				registraMsg("Produto", "Salvo com sucesso.", "info");
			}
			
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "pages/produtos";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			modelAndView = new ModelAndView(link);
			atualizarPagina = "/produtos";
			request.setAttribute("atualizarPagina", atualizarPagina);
			enviaMsg(request);
		}
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	@RequestMapping(value = "/atualizarCategoria", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void atualizarCategoria(HttpServletRequest request, HttpServletResponse response, Integer categoriaID, Boolean alterar, Boolean salvar, Boolean pesquisar, Categoria categoria) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		String link = "deslogar";
		
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			if(pesquisar) {
				Categoria c = categoriaDao.findById(categoriaID).get();
				if(c != null) {
					request.setAttribute("categoria", c);
				} else {
					List<Categoria> categorias = categoriaDao.buscarCategorias();
					request.setAttribute("categorias", categorias);
					registraMsg("Categoria", "Categoria não encontrada.", "erro");
				}
			} 
			else if (salvar) {
				Categoria c = new Categoria();
				c.setAtivo(true);
				c.setDescricao(categoria.getDescricao());
				categoriaDao.save(c);
								
				List<Categoria> categorias = categoriaDao.buscarCategorias();
				request.setAttribute("categorias", categorias);
				registraMsg("Categoria", "Alterada com sucesso.", "info");
			}
			else if (alterar) {
				Categoria c = categoriaDao.findById(categoriaID).get();
				if(c != null) {
					c.setAtivo(true);
					c.setDescricao(categoria.getDescricao());
					categoriaDao.save(c);
				} else {
					registraMsg("Categoria", "Categoria não encontrada.", "erro");
				}
				List<Categoria> categorias = categoriaDao.buscarCategorias();
				request.setAttribute("categorias", categorias);
				registraMsg("Categorias", "Salvo com sucesso.", "info");
			}
			request.setAttribute("usuarioSessao", usuarioSessao);
			link = "pages/categorias";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			atualizarPagina = "/categorias";
			request.setAttribute("atualizarPagina", atualizarPagina);
			enviaMsg(request);
		}
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	@RequestMapping(value = "/atualizarUsuario", method = {RequestMethod.POST,RequestMethod.GET}) // Link do submit do form e o method POST que botou la
	public void atualizarUsuario(HttpServletRequest request, HttpServletResponse response, Integer usuarioID, Boolean alterar, Boolean salvar, Boolean pesquisar, Usuario usuario) throws ServletException, IOException { // model é usado para mandar , e variavelNome está recebendo o name="nome" do submit feito na pagina principal 
		String link = "deslogar";
		
		HttpSession session = request.getSession();
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			link = "pages/usuarios";
			if(pesquisar) {
				Usuario u = usuarioDao.findById(usuarioID).get();
				if(u != null) {
					request.setAttribute("usuario", u);
				} else {
					List<Usuario> usuarios = usuarioDao.usuarios();
					request.setAttribute("usuarios", usuarios);
					registraMsg("Usuário", "Usuário não encontrado.", "erro");
				}
			} 
			else if (salvar) {
				if(usuarioDao.buscaLogin(usuario.getLogin()).size() == 0) {
					Usuario u = new Usuario();
					u.setAtivo(true);
					u.setLogin(usuario.getLogin());
					u.setNome(usuario.getNome());
					u.setPerfil(perfilDao.buscarFuncionario().get(0));
					if(usuario.getSenha() == null) {
						u.setSenha(usuario.getLogin());
					} else {
						u.setSenha(usuario.getSenha());
					}	
					u.setTelefone(usuario.getTelefone());
					usuarioDao.save(u);
					registraMsg("Usuário", "Salvo com sucesso.", "info");
				} else {
					registraMsg("Usuário", "Já existe usuário com este Login.", "erro");
				}
				List<Usuario> usuarios = usuarioDao.usuarios();
				request.setAttribute("usuarios", usuarios);
				
			}
			else if (alterar) {
				if(usuarioDao.buscaLogin(usuario.getLogin()).size() == 0) {
					Usuario u = usuarioDao.findById(usuarioID).get();
					if(u != null) {
						u.setAtivo(true);
						u.setAtivo(true);
						u.setLogin(usuario.getLogin());
						u.setNome(usuario.getNome());
						u.setPerfil(perfilDao.buscarFuncionario().get(0));
						u.setTelefone(usuario.getTelefone());
						usuarioDao.save(u);
						registraMsg("Usuário", "Alterado com sucesso.", "info");
					} else {
						registraMsg("Usuário", "Usuário não encontrado.", "erro");
					}
				} else {
					registraMsg("Usuário", "Já existe usuário com este Login.", "erro");
				}
				List<Usuario> usuarios = usuarioDao.usuarios();
				request.setAttribute("usuarios", usuarios);
				registraMsg("Usuários", "Salvo com sucesso.", "info");
			}
			
			request.setAttribute("usuarioSessao", usuarioSessao);
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			enviaMsg(request);
			atualizarPagina = "/usuarios";
			request.setAttribute("atualizarPagina", atualizarPagina);
		}
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); 
	}
	
	
	
	public void processaProduto(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Produto p = new Produto();
		List<Tabela> tabela = uploadExcelFile(file);
		try {
		for(int i=0; i<tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) p.setCodigo(conteudo.replace(".0", ""));
			if(coluna == 1) p.setDescricao(conteudo);
			if(coluna == 2){ try{ p.setCategoria(categoriaDao.buscarDeterminadaCategoria(conteudo.toUpperCase()));} catch(Exception e){} }
			if(coluna == 3) p.setValor(Double.parseDouble(conteudo));
			if(coluna == 4) p.setPrecoPromocional(Double.parseDouble(conteudo));
			if(coluna == 5) p.setEstoque(Integer.parseInt(conteudo.replace(".00", "").replace(".0", "")));
			if(finalLinha >= 5) {
				finalLinha = -1;
				produtoDao.save(p);
				p = new Produto();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			System.out.println("Erro: "+e);
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
	
	
	
	public void processaUsuario(@ModelAttribute MultipartFile file) throws Exception {
		int coluna = 0;
		int finalLinha = 0;
		String conteudo = "";
		Usuario p = new Usuario();
		List<Tabela> tabela = uploadExcelFile(file);
		try {
		for(int i=0; i<tabela.size(); i++) {
			coluna = tabela.get(i).getColuna();
			conteudo = tabela.get(i).getConteudo();
			// ::: Aqui varia de tabela pra tabela pra popular os campos :::
			if(coluna == 0) p.setLogin(conteudo);
			if(coluna == 1) p.setNome(conteudo);
			if(coluna == 2){ try{ p.setPerfil(perfilDao.buscarNome(conteudo.toUpperCase()).get(0));} catch(Exception e){} }
			if(coluna == 3) p.setTelefone(conteudo);
			if(finalLinha >= 3) {
				finalLinha = -1;
				p.setAtivo(true);
				p.setSenha("controle21");
				usuarioDao.save(p);
				p = new Usuario();
			}
			finalLinha++;
		}
		} catch(Exception e) {
			System.out.println("Erro: "+e);
			registraMsg("Upload", "Erro: " + e, "erro");
		}
	}
	
	
	
	@RequestMapping(value = "/pedidos", method = {RequestMethod.GET, RequestMethod.POST}) // Pagina de Vendas
	public void pedidos(HttpServletRequest request, HttpServletResponse response, String nota, String pesquisarVendaID) throws ServletException, IOException { //Fun��o e alguns valores que recebe...
		HttpSession session = request.getSession();
		ModelAndView modelAndView = new ModelAndView("deslogar"); //JSP que ir� acessar
		String atualizarPagina = "";
		String itemMenuSelecionado = "";
		Usuario usuarioSessao = new Usuario();
		if(session.getAttribute("usuarioSessao") != null) {
			usuarioSessao = (Usuario) session.getAttribute("usuarioSessao");
		}
		String link = "deslogar";
		if(usuarioSessao!= null && usuarioSessao.getId() != null) {
			link = "/pages/pedidos";
			itemMenuSelecionado = "pedido";
			request.setAttribute("itemMenuSelecionado", itemMenuSelecionado);
			List<Venda> vendas = new ArrayList<Venda>();
			if(nota == null) {
				vendas = vendaDao.ultimas();
			} else {
				vendas = vendaDao.nota(nota);
			}
				List<Venda> vendaAnterior = vendas;
				List<Venda> vendaFinal = new ArrayList<Venda>();
				int ini = 0;
				for(Venda v : vendas) {
					if(ini > 0 ) {
						if(v.getPedido() != vendaAnterior.get(ini-1).getPedido()) {
							vendaFinal.add(v);
						}
					} else {
						vendaFinal.add(v);
					}
					ini++;
				}
				vendas.clear();
				vendas = vendaFinal;
			
			
			if(pesquisarVendaID != null) {
				List<Venda> vendaSelecionada = vendaDao.porPedido(pesquisarVendaID);
				//Calculando o Total
				Double totalDaNota = 0.0;
				for(Venda venda : vendaSelecionada) {
					totalDaNota = totalDaNota + venda.getSubtotal();
				}
				for(Venda venda : vendaSelecionada) {
					venda.setTotal(totalDaNota);
					vendaDao.save(venda);
				}
				//Calculando o Total
				
				request.setAttribute("vendaSelecionada", vendaSelecionada);
			}
			
			request.setAttribute("usuarioSessao", usuarioSessao);
			request.setAttribute("vendas", vendas);
			enviaMsg(request);

		}
		request.getRequestDispatcher("/WEB-INF/jsp/"+link+".jsp").forward(request, response); //retorna a variavel
	}
	

}
