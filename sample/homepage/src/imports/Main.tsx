import svgPaths from "./svg-xy4598t6xw";
import imgRectangle1 from "figma:asset/5dea5f922accec2ba1cee51599916c0eca674981.png";

function MainBtnBorder() {
  return (
    <div className="box-border content-stretch flex flex-col h-[50px] items-center justify-center px-[31px] py-[8px] relative rounded-[28px] shrink-0 w-[172px]" data-name="Main btn border">
      <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[28px]" />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[#949494] text-[12px] text-center text-nowrap whitespace-pre">I’m new here</p>
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-black text-center text-nowrap whitespace-pre">Chat with AI</p>
    </div>
  );
}

function MainBtnBlack() {
  return (
    <div className="bg-white box-border content-stretch flex gap-[10px] h-[50px] items-center justify-center px-[55px] py-[17px] relative rounded-[28px] shrink-0 w-[172px]" data-name="Main btn Black">
      <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[28px]" />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-black text-center text-nowrap whitespace-pre">Menu</p>
    </div>
  );
}

function Frame1() {
  return (
    <div className="absolute content-stretch flex gap-[12px] h-[55px] items-center left-1/2 top-[726px] translate-x-[-50%]">
      <MainBtnBorder />
      <MainBtnBlack />
    </div>
  );
}

function VuesaxOutlineGlobal() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/global">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="global">
          <path d={svgPaths.p261e480} fill="var(--fill-0, black)" id="Vector" />
          <path d={svgPaths.p2bc02600} fill="var(--fill-0, black)" id="Vector_2" />
          <path d={svgPaths.p3fd764f0} fill="var(--fill-0, black)" id="Vector_3" />
          <path d={svgPaths.pb29df00} fill="var(--fill-0, black)" id="Vector_4" />
          <path d={svgPaths.p1a259180} fill="var(--fill-0, black)" id="Vector_5" />
          <path d="M24 0H0V24H24V0Z" fill="var(--fill-0, black)" id="Vector_6" opacity="0" />
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineGlobal() {
  return (
    <div className="relative shrink-0 size-[24px]" data-name="default/outline/global">
      <VuesaxOutlineGlobal />
    </div>
  );
}

function Frame() {
  return (
    <div className="content-stretch flex gap-[6px] items-center relative shrink-0">
      <DefaultOutlineGlobal />
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[16px] text-black text-nowrap whitespace-pre">English</p>
    </div>
  );
}

function IconBtnSmall() {
  return (
    <div className="absolute box-border content-stretch flex flex-col gap-[10px] h-[40px] items-start left-[268px] px-[14px] py-[8px] rounded-[20px] top-[83px]" data-name="icon btn small">
      <div aria-hidden="true" className="absolute border border-[#949494] border-solid inset-0 pointer-events-none rounded-[20px]" />
      <Frame />
    </div>
  );
}

function TitleBold1() {
  return (
    <div className="absolute h-[32px] left-[23px] top-[570px] w-[112px]" data-name="Title bold 28">
      <p className="absolute font-['Ubuntu:Bold',sans-serif] inset-0 leading-[normal] not-italic text-[28px] text-black text-nowrap whitespace-pre">Table 24</p>
    </div>
  );
}

function TitleBold() {
  return (
    <div className="absolute h-[23px] left-[22px] top-[87px] w-[219px]" data-name="Title bold 20">
      <p className="absolute bottom-0 font-['Ubuntu:Bold',sans-serif] leading-[normal] left-0 not-italic right-[32.88%] text-[20px] text-black text-nowrap top-0 whitespace-pre">The Restaurant</p>
    </div>
  );
}

function MainBtnBlack1() {
  return (
    <div className="absolute bg-black box-border content-stretch flex gap-[10px] h-[50px] items-center justify-center left-[22px] px-[134px] py-[17px] rounded-[28px] top-[793px] w-[356px]" data-name="Main btn Black">
      <p className="font-['Ubuntu:Medium',sans-serif] leading-[normal] not-italic relative shrink-0 text-[18px] text-center text-nowrap text-white whitespace-pre">Order Fast</p>
    </div>
  );
}

function VuesaxOutlineArrowCircleRight() {
  return (
    <div className="absolute contents inset-0" data-name="vuesax/outline/arrow-circle-right">
      <svg className="block size-full" fill="none" preserveAspectRatio="none" viewBox="0 0 24 24">
        <g id="arrow-circle-right">
          <path d={svgPaths.p261e480} fill="var(--fill-0, white)" id="Vector" />
          <path d={svgPaths.p1f7280} fill="var(--fill-0, white)" id="Vector_2" />
          <g id="Vector_3" opacity="0"></g>
        </g>
      </svg>
    </div>
  );
}

function DefaultOutlineArrowCircleRight() {
  return (
    <div className="absolute left-[342px] size-[24px] top-[806px]" data-name="default/outline/arrow-circle-right">
      <VuesaxOutlineArrowCircleRight />
    </div>
  );
}

function Group() {
  return (
    <div className="absolute contents left-[22px] top-[793px]">
      <MainBtnBlack1 />
      <DefaultOutlineArrowCircleRight />
    </div>
  );
}

export default function Main() {
  return (
    <div className="bg-white relative size-full" data-name="Main">
      <p className="absolute font-['Ubuntu:Regular',sans-serif] h-[97px] leading-[24px] left-[23px] not-italic text-[#949494] text-[16px] top-[614px] w-[356px]">
        Lorem ipsum dolor sit amet consectetur. Neque placerat leo dapibus aliquet velit. Amet tempor mauris volutpat egestas et dui leo in gravida. Mus mauris ut aliquam faucibus<span className="text-[#0b99ff]">...more</span>
      </p>
      <Frame1 />
      <div className="absolute h-[420px] left-1/2 rounded-[24px] top-[138px] translate-x-[-50%] w-[358px]">
        <img alt="" className="absolute inset-0 max-w-none object-50%-50% object-cover pointer-events-none rounded-[24px] size-full" src={imgRectangle1} />
      </div>
      <IconBtnSmall />
      <TitleBold1 />
      <TitleBold />
      <Group />
    </div>
  );
}